Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269527AbRHHVJC>; Wed, 8 Aug 2001 17:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269541AbRHHVIw>; Wed, 8 Aug 2001 17:08:52 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:26385 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269527AbRHHVId>; Wed, 8 Aug 2001 17:08:33 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: PCI NVRAM Memory Card
Date: 8 Aug 2001 14:08:36 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9ks9ok$jl6$1@cesium.transmeta.com>
In-Reply-To: <5.1.0.14.0.20010622101907.03ac21b0@192.168.0.5>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <5.1.0.14.0.20010622101907.03ac21b0@192.168.0.5>
By author:    Mike Jadon <mikej@umem.com>
In newsgroup: linux.dev.kernel
>
> My company has released a PCI NVRAM memory card but we haven't developed a 
> Linux driver for it yet.  We want the driver to be open to developers to 
> build upon.  Is there a specific path we should follow with this being our 
> goal?  In researching Linux driver development I have come across "GPL" or 
> "LGPL".  Where do you recommend we go to find out more about this 
> development process?
> 
> Thanks and my apologies for using a technical forum for this question, but 
> wanted to go to the right source.
> 

Since you're willing to open the source, you are probably best off
making the kernel portion of your driver GPL and submit it for
integration into the main kernel tree.  The drivers included in the
main kernel tree tend to be the ones that work reliably over time, and
are therefore most valuable to your customers.

As someone else mentioned, user-space libraries should be LGPL.

It should be pointed out that you, as the copyright holder, can
"dual-license" the code if you want to use the same code for
closed-source projects.  If so, the mention of the dual license nature
should be specified in the open code, to keep you from getting in a
sticky situation when someone submits patches.  The most formal such
license is probably the MPL (Mozilla Public License); I do not know
if MPL'd code would be considered "GPL compatible" and therefore
eligible for inclusion in the main kernel.

Another possible license used in a few places is the "New BSD" license
(as opposed to the "Old BSD" license, with the so-called "advertising
clause".)  The BSD license allows *anyone* (including yourselves, of
course, but also your competitors) to take the code and use it in a
closed-source project.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
