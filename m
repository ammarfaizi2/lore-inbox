Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbUJZVOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUJZVOp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 17:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUJZVOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 17:14:44 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:51518 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261472AbUJZVOj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 17:14:39 -0400
Date: Wed, 27 Oct 2004 01:15:14 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.9-bk7] Select cpio_list or source directory for initramfs image updates [u]
Message-ID: <20041026231514.GA3285@mars.ravnborg.org>
Mail-Followup-To: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>,
	Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
	torvalds@osdl.org,
	Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
References: <200410200849.i9K8n5921516@mail.osdl.org> <1098533188.668.9.camel@nosferatu.lan> <20041026221216.GA30918@mars.ravnborg.org> <1098824849.12420.60.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098824849.12420.60.camel@nosferatu.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 11:07:29PM +0200, Martin Schlemmer [c] wrote:
 
> > Current patch will not rebuild image if one of the
> > programs listed are changed. But it should give a good
> > foundation to do so.
> > 
> 
> I will see if I get the time to get that implemented elegantly if
> you do not beat me to it.

Something as simple as putting relevant timestamps in the generated
file as coment should do it.
If timestamp differ then initramfs_list will be updated and initramfs
image will be remade.

All changes isolated to gen_initramfs_list.sh.
Care to give that a spin?

	Sam
