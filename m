Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbVHOMxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbVHOMxl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 08:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVHOMxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 08:53:41 -0400
Received: from nproxy.gmail.com ([64.233.182.194]:64290 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750741AbVHOMxk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 08:53:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TSxOwQfbjY5/q2dEDn6T1lCz1tvoIYop8HkYRe5JSshVN59nd0595Ud6AoXM1h1piMgYYVvnQSmOeOzu3gL+xfSJCWvLSSkT1ZmOhxRECgKc44q+QXDudb7QIGPqhnPQ/SDkqRRdkIh41ygGSGUb0XXBRQdMEDcPdN5cYC0A23M=
Message-ID: <58cb370e0508150553d4aed03@mail.gmail.com>
Date: Mon, 15 Aug 2005 14:53:38 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: rc6 keeps hanging and blanking displays where rc4-mm1 works fine.
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       akpm@osdl.org
In-Reply-To: <1123842774.22460.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>
	 <20050805104025.GA14688@aitel.hist.no>
	 <21d7e99705080503515e3045d5@mail.gmail.com>
	 <42F89F79.1060103@aitel.hist.no> <42FC7372.7040607@aitel.hist.no>
	 <1123842774.22460.22.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2005-08-12 at 12:01 +0200, Helge Hafting wrote:
> > solveable by resizing.  But the machine will occationally hang, forcing
> > me to
> > use the reset button.  I lost my mbox file to this (from an ext3 fs, on
> > raid-1 on scsi.)
> 
> Unless you are using data=journal and have turned write cache off on
> your IDE drives that is expected. Metadata journalling protects your
> file system intgerity. Data journalling is more expensive but will
> protect your file integrity if the disk layer is also correctly set up.
> Unfortunately the IDE layer defaults the wrong way and despite many
> complaints has not been changed. In later 2.6 with modern drives you can

Changing defaults is not that easy, disabling write-cache shortens HDD
life considerably (discussed on LKML).

Recommend solution is to disable write-cache w/ hdparm or use barrier mode.

> also enable barrier mode on the IDE layer which gives better results
> than turning off the write cache.
