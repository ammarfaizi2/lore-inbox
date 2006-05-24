Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbWEXEsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbWEXEsW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 00:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbWEXEsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 00:48:22 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:34623 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932575AbWEXEsV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 00:48:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t+jqYQ/dCuiDFAjPXbhQzDfAdcni5sT5A7MitxYyvOxIKdJ0fBt4/6E3yBfafCxsm0PXg10/uIfqyyp4B0kPkwzzYcldhFhxQwdcdhXEHTgPP0MSNdDN4L9W699hQLCgkGVYFRKQBq3+Bgw7oF0MqXXqjXgRAJJRPmsvho2pHWA=
Message-ID: <9e4733910605232148sf87b62eq5362d520e43c2e70@mail.gmail.com>
Date: Wed, 24 May 2006 00:48:20 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <4472E3D8.9030403@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <44700ACC.8070207@gmail.com>
	 <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>
	 <1148379089.25255.9.camel@localhost.localdomain>
	 <4472E3D8.9030403@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/06, Jeff Garzik <jeff@garzik.org> wrote:
> OTOH, I think a perfect video driver would be in kernel space, and do
>
> * delivery of GPU commands from userspace to hardware, hopefully via
> zero-copy DMA.  For older cards without a true instruction set, "GPU
> commands" simply means userspace prepares hardware register
> read/write/test commands, and blasts the sequence to hardware at the
> appropriate moment (a la S3 Savage's BCI).

You have to security check those commands in the kernel driver to keep
normal users from using the GPU to do nasty things. Users can only
play with memory that they own and no ones else's.

-- 
Jon Smirl
jonsmirl@gmail.com
