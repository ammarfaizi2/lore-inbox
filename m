Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270720AbTHSPJW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 11:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270797AbTHSPED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 11:04:03 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:14746
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S270628AbTHSO7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 10:59:10 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Jeff Garzik <jgarzik@pobox.com>,
       "Ihar 'Philips' Filipau" <filia@softhome.net>
Subject: Re: [PATCH] Re: [PATCH] scsi.h uses "u8" which isn't defined.
Date: Tue, 19 Aug 2003 08:32:24 -0400
User-Agent: KMail/1.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <lRjc.6o4.3@gated-at.bofh.it> <3F4120DD.3030108@softhome.net> <20030818190421.GN24693@gtf.org>
In-Reply-To: <20030818190421.GN24693@gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308190832.24744.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 August 2003 15:04, Jeff Garzik wrote:

> >    But generally idea is good: keep interface separately from
> > implementation.
>
> No, the idea is to physically separate the headers.
>
> include/{linux,asm} is currently copied to userspace, hacked a bit,
> and then shipped as the "glibc-kernheaders" package.

Or used directly by uclibc (and linux from scratch) to build the library 
against.

> I would rather that the kernel developers directly maintained this
> interface, by updating headers in include/abi, rather than ad-hoc by
> distro people.
>
> 	Jeff

Okay, I'd like to ask about the headers thing:

I've got a project using uclibc, and build it myself, currently against the 
2.4 headers.  What's the plan for 2.6?  Everything I've seen on the subject 
is "using kernel headers directly from userspace is evil, even to build your 
libc against, but we currently offer no alternative, so go bug your libc 
maintainer and have THEM do it..."

I'm hoping I've missed something in the months I was off the list this spring, 
but haven't quite figured out what to search for in the archives yet...

Rob


