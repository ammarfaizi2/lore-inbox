Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267361AbSKPVFz>; Sat, 16 Nov 2002 16:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267362AbSKPVFz>; Sat, 16 Nov 2002 16:05:55 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:53000 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267361AbSKPVFy>; Sat, 16 Nov 2002 16:05:54 -0500
Date: Sat, 16 Nov 2002 22:12:14 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5: Help for choice questions doesn't work
In-Reply-To: <20021116205613.GE28356@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0211162204420.2109-100000@serv>
References: <20021116205613.GE28356@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 16 Nov 2002, Adrian Bunk wrote:

> In 2.5.47 the help for choice questions (e.g. "Processor family" or
> "High Memory Support" in the "Processor type and features" menu) doesn't
> work in "make menuconfig", there's always a "There is no help available
> for this kernel option." displayed.

Move the main help to the choice entry itself. All front ends expect the 
help now there. E.g.

choice
	prompt "Processor family"
	default M686
        ---help---
	  This is the processor type of your CPU. This information is used for
	  optimizing purposes. In order to compile a kernel that can run on
	  all x86 CPU types (albeit not optimally fast), you can specify
	  "386" here.
	  ...

The choice options can still have there own help entries, but only xconfig 
makes use of it.
I didn't do this automatically, since most help text entries need to be 
splitted somehow. I wanted to do this for a few common entries, but I 
haven't found the time yet.

bye, Roman

