Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287952AbSABUsE>; Wed, 2 Jan 2002 15:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287948AbSABUrz>; Wed, 2 Jan 2002 15:47:55 -0500
Received: from hog.ctrl-c.liu.se ([130.236.252.129]:46610 "HELO
	hog.ctrl-c.liu.se") by vger.kernel.org with SMTP id <S287955AbSABUrn>;
	Wed, 2 Jan 2002 15:47:43 -0500
From: Christer Weinigel <wingel@hog.ctrl-c.liu.se>
To: robert@schwebel.de
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, jason@mugwump.taiga.com,
        anders@alarsen.net, rkaiser@sysgo.de
In-Reply-To: <Pine.LNX.4.33.0201021457300.3056-100000@callisto.local> (message
	from Robert Schwebel on Wed, 2 Jan 2002 14:58:48 +0100 (CET))
Subject: Re: [PATCH][RFC] AMD Elan patch
Reply-To: wingel@t1.ctrl-c.liu.se
In-Reply-To: <Pine.LNX.4.33.0201021457300.3056-100000@callisto.local>
Message-Id: <20020102204741.3268F36F9F@hog.ctrl-c.liu.se>
Date: Wed,  2 Jan 2002 21:47:41 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Schwebel wrote:
> True, but does "Family 4, Model 10" always mean "Elan SC410"? An official
> source from AMD would be great here. Is anybody from AMD on the list or
> does anybody have the address of a contact person?

It seems as if "Family 4, Model 10" isn't enought, but the Users
Manual describes how to detect an Elan SC4x0 Processor:

3.6 CPU CORE IDENTIFICATION USING THE CPUID INSTRUCTION

The ElanSC400 and ElanSC410 microcontrollers are the first members of
a new family of embedded devices. The CPUID instruction can be used to
identify a processor as belonging to this family.

The Am486 CPU core in the ElanSC400 and ElanSC410 microcontrollers is
the first CPU AMD has made with a write-back cache and no FPU, so
these tests should be sufficient to uniquely identify the family.

Using the CPUID instruction the microcontroller can be done with the
following steps, as shown in the code sample in Section 3.6.3:

    * Make sure the manufacturer name is "AuthenticAMD".

    * Make sure the device is described as a 486 SX1 with a write-back
      cache.  

If it passes all the tests it must be an ElanSC400 microcontroller or
derivative.

If it's worth it or not, I don't know, I'm just curious, it has been
years since I did anything with the Elan processor for real. :-)

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"
