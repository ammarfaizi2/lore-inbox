Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbSLUU1S>; Sat, 21 Dec 2002 15:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbSLUU1S>; Sat, 21 Dec 2002 15:27:18 -0500
Received: from virgo.i-cable.com ([203.83.111.75]:47021 "HELO
	virgo.i-cable.com") by vger.kernel.org with SMTP id <S264654AbSLUU1R>;
	Sat, 21 Dec 2002 15:27:17 -0500
From: "Sampson Fung" <sampson@attglobal.net>
To: <linux-kernel@vger.kernel.org>
Subject: First Bug Found : RE: How to help new comers trying the v2.5x series kernels.
Date: Sun, 22 Dec 2002 04:35:10 +0800
Message-ID: <000c01c2a930$754a6790$0100a8c0@noelpc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <20021221190503.GA1508@mars.ravnborg.org>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Sam Ravnborg
> Sent: Sunday, December 22, 2002 3:11 AM
> To: Sampson Fung
> Cc: 'John Bradford'; 'Sampson Fung'; linux-kernel@vger.kernel.org
> Subject: Re: How to help new comers trying the v2.5x series kernels.
>
>
> On Sun, Dec 22, 2002 at 02:30:13AM +0800, Sampson Fung wrote:
> > Where is the default .config?  I am eager to have a try.
>
> Try "make help"
>
> That will teach you about:
> make defconfig                <= Linus's own configuration
> (well more or less)
> make allnoconfig      <= Minimal config, but often it does not compile
>

make defconfig compiled ok.  modules are enabled, although only
"kernel/drivers/net/dummy.ko" exist.
It is bootable on my system in spite of P4 cpu selected in .config while
mine is a PIII.
And "lsmod" returns only the header row.  (A good sing for me)

Here is my first problem:  (This problem exist since v2.5.49, and up to
v2.5.52)
In will be talk about the following 4 lines below:

=============================

General setup  --->
Loadable module support  --->
Processor type and features  --->
============================     
1.	I ssh into my box, terminal is ANSI, rows=25, columns=80
a.	Just after "make menuconfig", what I get is:

The letter 'P' is actuall at Column 5
=============================

General setup  --->
Loadable module support  --->
Processor type and features  --->
============================     

b.	Press <down arrow> once, what I get is:

The letter 'P' is actuall at Column 5
The letter 'C' and second 'G' is actuall at Column 15
=============================
                Code maturity level options  --->
General seGeneral setup  --->
Loadable module support  --->
Processor type and features  --->
============================     

c.	If I kept pressing <down arrow>, the first letter of the current
title will be overlay to the column 15 of the current, for each line.

2.	If I "make menuconfig" in Console, where terminal is "linux",
the "horizontal displacement" still occur but only at 2 columns to the
right hand side only.

3.	The same problem for v2.4.20

Is this a know bug?  Where should I search before posting here? 

Sampson
A new comer to Kernel testing.


