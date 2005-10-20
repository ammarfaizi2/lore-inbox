Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbVJTVzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbVJTVzJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 17:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbVJTVzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 17:55:09 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:27292 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S932518AbVJTVzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 17:55:07 -0400
Date: Thu, 20 Oct 2005 23:54:59 +0200
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: 7eggert@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix vgacon blanking
Message-ID: <20051020215459.GG23609@ojjektum.uhulinux.hu>
References: <4ZLja-4gH-5@gated-at.bofh.it> <E1EShsL-0000tJ-Fr@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EShsL-0000tJ-Fr@be1.lrz>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2005 at 11:23:01PM +0200, Bodo Eggert wrote:
> Pozsar Balazs <pozsy@uhulinux.hu> wrote:
> 
> > This patch fixes a long-standing vgacon bug: characters with the bright
> > bit set were left on the screen and not blacked out.
> > All I did was that I lookuped up some examples on the net about setting
> > the vga palette, and added the call missing from the linux kernel, but
> > included in all other ones. It works for me.
> 
> This is strange, since according to my documentation, the value should have
> been initialized to 0xff and never been changed. Can you test setting this
> value during initialisation (around line 259, if I read correctly) instead?
> I don't know if I can test it myself soon enough.
> 
> (I'm not the maintainer, I just happen to have some documentation).

Maybe I can test it tomorrow. But as the posted patch work as-is, cannot 
do any harm because it just makes sure the register is set as it should 
be, and we are talking about a not-so-often called slowpath, I think it 
should just be merged and get forgotten, without making a big hassle 
making around it :)
On the other side, as this bug is a little annoyment, it can be tested 
in -mm until 2.6.15 or so. I have the cure now, so I'm happy with it :)


-- 
pozsy
