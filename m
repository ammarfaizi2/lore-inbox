Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbVILOqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbVILOqA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVILOqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:46:00 -0400
Received: from host27-37.discord.birch.net ([65.16.27.37]:1207 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1751198AbVILOp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:45:59 -0400
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Harald Dunkel'" <harald.dunkel@t-online.de>,
       "'Jim Gifford'" <maillist@jg555.com>
Cc: "'Jeff Garzik'" <jgarzik@pobox.com>, "'Andi Kleen'" <ak@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Pure 64 bootloaders
Date: Mon, 12 Sep 2005 09:50:20 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcW2NWmImiEKh3lOQme/DrC1XBoZygBcpWiw
In-Reply-To: <43232660.5070504@t-online.de>
Message-ID: <EXCHG2003Aj5p1Fjxe0000006ad@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 12 Sep 2005 14:42:22.0194 (UTC) FILETIME=[2F10B520:01C5B7A8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Harald Dunkel
> Sent: Saturday, September 10, 2005 1:31 PM
> To: Jim Gifford
> Cc: Jeff Garzik; Andi Kleen; linux-kernel@vger.kernel.org
> Subject: Re: Pure 64 bootloaders
> 
> > 
> > 
> > /lib64 is an awful scheme.  I'd avoid it.
> > 
> 
> Indeed. It just helps to keep unclean 32bit applications alive.
> 

Reality is that it is difficulty to remove the older junk.

I guess I see 5 choices:

#1:
Use lib for whatever the standard os/arch size is.

Use lib32 for the non-standard size.

#2: 
Continue the current mess.

#3:
Use both lib32 and lib64 and maybe put a link from lib to the
default one, probably lib64.

#4:
Use both lib32 and lib64 and don't put a link.

#5:
Designate the bit size in the name of the lib, ie libc.so64 or
libc.so32 or something similar and put them all in the same
directory and let the lib loading code take care of finding the
correct size.

#5 would seem to be the most robust and simplest to administer,
and the most obvious, and the easiest to modify if something like
this was to happen again.

Who came up with lib64?  I thought I first saw it either on a
irix 6 machine or a early solaris 2.x machine.

                   Roger
> Maybe you would like to check Debian for amd64? The 32bit 
> stuff is purely optional (except for the boot loaders, AFAIK).
> 
> http://www.debian.org/ports/amd64/
> 
> 
> Regards
> 
> Harri
> 

