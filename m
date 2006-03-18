Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWCRO4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWCRO4k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 09:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWCRO4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 09:56:40 -0500
Received: from mail21.bluewin.ch ([195.186.18.66]:36560 "EHLO
	mail21.bluewin.ch") by vger.kernel.org with ESMTP id S932247AbWCRO4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 09:56:39 -0500
Date: Sat, 18 Mar 2006 09:55:48 -0500
To: Nico Schottelius <nico-kernel2@schottelius.org>,
       LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       Arthur Othieno <apgo@patchbomb.org>
Cc: trivial@kernel.org
Subject: Re: [PATCH] doc: Updated Documentation/nfsroot.txt
Message-ID: <20060318145548.GA2255@krypton>
References: <20060318110232.GB4336@schottelius.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060318110232.GB4336@schottelius.org>
User-Agent: Mutt/1.5.11+cvs20060126
From: apgo@patchbomb.org (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 12:02:32PM +0100, Nico Schottelius wrote:
> Hello LKML!
> 
> What am I doing terrible wrong that I do not get any comment on this
> patch?

I'll fall out as patch monkey in re-transmission mode now. Please send
patch to <trivial@kernel.org> (added to Cc). Thanks.

> 
> ----- Forwarded message from Arthur Othieno <apgo@patchbomb.org> -----
> 
> Date: Tue, 14 Feb 2006 11:05:53 -0500
> To: akpm@osdl.org
> Cc: Nico Schottelius <nico-kernel@schottelius.org>,
> 	Arthur Othieno <apgo@patchbomb.org>
> Subject: [PATCH] doc: Updated Documentation/nfsroot.txt
> From: Arthur Othieno <apgo@patchbomb.org>
> 
> From: Nico Schottelius <nico-kernel@schottelius.org>
> 
> I today booted the first time my embedded device using Linux 2.6.15.2,
> which was booted by pxelinux, which then bootet itself from the nfsroot.
> 
> This went pretty fine, but when I was reading through
> Documentation/nfsroot.txt I saw that there are some more modern versions
> available of loading the kernel and passing parameters.
> 
> So I added them and the patch for that is attached to this mail.
> 
> Signed-off-by: Nico Schottelius <nico-kernel@schottelius.org>
> Signed-off-by: Arthur Othieno <apgo@patchbomb.org>
> 
> ---
> 
>  Documentation/nfsroot.txt |   17 ++++++++++++++---
>  1 files changed, 14 insertions(+), 3 deletions(-)
> 
> bb5fd479f34c5c53f3e3316052656c7795c02f90
> diff --git a/Documentation/nfsroot.txt b/Documentation/nfsroot.txt
> index a87d4af..d56dc71 100644
> --- a/Documentation/nfsroot.txt
> +++ b/Documentation/nfsroot.txt
> @@ -3,6 +3,7 @@ Mounting the root filesystem via NFS (nf
>  
>  Written 1996 by Gero Kuhlmann <gero@gkminix.han.de>
>  Updated 1997 by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
> +Updated 2006 by Nico Schottelius <nico-kernel-nfsroot@schottelius.org>
>  
>  
>  
> @@ -168,7 +169,6 @@ depend on what facilities are available:
>  	root. If it got a BOOTP answer the directory name in that answer
>  	is used.
>  
> -
>  3.2) Using LILO
>  	When using LILO you can specify all necessary command line
>  	parameters with the 'append=' command in the LILO configuration
> @@ -177,7 +177,11 @@ depend on what facilities are available:
>  	LILO and its 'append=' command please refer to the LILO
>  	documentation.
>  
> -3.3) Using loadlin
> +3.3) Using GRUB
> +	When you use GRUB, you simply append the parameters after the kernel
> +	specification: "kernel <kernel> <parameters>" (without the quotes).
> +
> +3.4) Using loadlin
>  	When you want to boot Linux from a DOS command prompt without
>  	having a local hard disk to mount as root, you can use loadlin.
>  	I was told that it works, but haven't used it myself yet. In
> @@ -185,7 +189,7 @@ depend on what facilities are available:
>  	lar to how LILO is doing it. Please refer to the loadlin docu-
>  	mentation for further information.
>  
> -3.4) Using a boot ROM
> +3.5) Using a boot ROM
>  	This is probably the most elegant way of booting a diskless
>  	client. With a boot ROM the kernel gets loaded using the TFTP
>  	protocol. As far as I know, no commercial boot ROMs yet
> @@ -194,6 +198,13 @@ depend on what facilities are available:
>  	and its mirrors. They are called 'netboot-nfs' and 'etherboot'.
>  	Both contain everything you need to boot a diskless Linux client.
>  
> +3.6) Using pxelinux
> +	Using pxelinux you specify the kernel you built with
> +	"kernel <relative-path-below /tftpboot>". The nfsroot parameters
> +	are passed to the kernel by adding them to the "append" line.
> +	You may perhaps also want to fine tune the console output,
> +	see Documentation/serial-console.txt for serial console help.
> +
>  
>  
>  
> -- 
> 1.1.5
> 
> 
> ----- End forwarded message -----
> 
> -- 
> Please reply to nico-kernel2 (same domain as sending address).
> Replying to this address needs a confirmation, but works, too.

Setting From: address on your end is trivial. Having to jump through
hoops like these to provide any feedback is just a waste of peoples'
time, really.
