Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVC2VEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVC2VEQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 16:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVC2VEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 16:04:15 -0500
Received: from main.gmane.org ([80.91.229.2]:13741 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261428AbVC2VEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 16:04:09 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: [PATCH] embarassing typo
Date: Tue, 29 Mar 2005 23:02:21 +0200
Message-ID: <yw1xd5ti17z6.fsf@ford.inprovide.com>
References: <1112128584.25954.6.camel@tux.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:uAfr4ReCL00vdslLPuGaNg9qCGU=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ronald S. Bultje" <rbultje@ronald.bitfreak.net> writes:

> --- linux-2.6.5/drivers/media/video/zr36050.c.old	16 Sep 2004 22:53:27 -0000	1.2
> +++ linux-2.6.5/drivers/media/video/zr36050.c	29 Mar 2005 20:30:23 -0000
> @@ -419,7 +419,7 @@
>  	dri_data[2] = 0x00;
>  	dri_data[3] = 0x04;
>  	dri_data[4] = ptr->dri >> 8;
> -	dri_data[5] = ptr->dri * 0xff;
> +	dri_data[5] = ptr->dri & 0xff;

Hey, that's a nice obfuscation of a simple negation.

BTW, when assigning to a char type, is the masking really necessary at
all?  I can't see that it should make a difference.  Am I missing
something subtle?

-- 
Måns Rullgård
mru@inprovide.com

