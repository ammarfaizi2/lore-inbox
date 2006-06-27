Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWF0FkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWF0FkT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWF0FkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 01:40:19 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:23196 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932079AbWF0FkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 01:40:16 -0400
Date: Tue, 27 Jun 2006 07:39:50 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Daniel Ritz <daniel.ritz-ml@swissonline.ch>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oom-killer problem
Message-ID: <20060627053950.GA26435@mars.ravnborg.org>
References: <200606270028.16346.daniel.ritz-ml@swissonline.ch> <Pine.LNX.4.64.0606261604180.3927@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606261604180.3927@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 04:05:40PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 27 Jun 2006, Daniel Ritz wrote:
> >
> > reverting the attached patch fixes the problem...
> 
> Michal, can you also confirm that just doing a simple revert of that one 
> commit makes things work for you?
> 
> Sam, if I don't hear otherwise from you, and Michael confirms, I'll just 
> revert it for now, and you can figure out how to fix it without breakage?
I will try to find time during the weekend to track down the cause of
this.
But by reverting said patch you also have to revert:
566f81ca598f80de03e80a9a743e94b65b4e017e

This is the patch where make -rR is enabled and that one initally caused
problems for ia64.

	Sam
