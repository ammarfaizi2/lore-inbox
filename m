Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280738AbRKSWUE>; Mon, 19 Nov 2001 17:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280750AbRKSWT5>; Mon, 19 Nov 2001 17:19:57 -0500
Received: from hera.cwi.nl ([192.16.191.8]:64984 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S280738AbRKSWTn>;
	Mon, 19 Nov 2001 17:19:43 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 19 Nov 2001 22:19:41 GMT
Message-Id: <UTC200111192219.WAA17887.aeb@cwi.nl>
To: adam@yggdrasil.com, andre@linux-ide.org
Subject: Re: Notes on ATA/133 patch (ide.2.4.14.11062001.patch)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2001 at 04:59:21AM -0800, Adam J. Richter wrote:

> I do not yet understand the purpose of ide_xlate_1024
> to understand whether it really is specific to the
> MSDOS style of partition labeling.

Yes, it is.

When DOS had a 528 MB limit various kludges were developed
to make larger disks available. BIOS-kludges went under the
name of "translation". Kludges that avoided the BIOS went
under the name "Disk Manager". Linux has some detailed knowledge
about these kludges, enough to enable Linux to successfully
share a disk with a DOS using translation and/or Disk Manager.

All of this stuff is totally obsolete today.
I think ide_xlate_1024 and family can be ripped out of 2.5
and nobody will notice, especially since it will be a long
time before 2.6.

Andries
