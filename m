Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317693AbSHBCHE>; Thu, 1 Aug 2002 22:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317694AbSHBCHE>; Thu, 1 Aug 2002 22:07:04 -0400
Received: from smtp.castel.nl ([195.85.130.71]:63406 "EHLO
	mastermail.keyaccess.nl") by vger.kernel.org with ESMTP
	id <S317693AbSHBCHD>; Thu, 1 Aug 2002 22:07:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rene Herman <rene.herman@keyaccess.nl>
To: linux-kernel@vger.kernel.org
Subject: Documentation for Pro Audio Spectrum?
Date: Fri, 2 Aug 2002 04:15:13 +0200
X-Mailer: KMail [version 1.2]
References: <20020802010840.53647.qmail@mail.com>
In-Reply-To: <20020802010840.53647.qmail@mail.com>
MIME-Version: 1.0
Message-Id: <02080204151303.00253@7ixe4>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 August 2002 03:08, Dave Jones wrote:

>>>> Are there any OSS drivers for any particular cards for which we
>>>> don't have an equivalent ALSA driver ?
>>>
>>> At least the Media Vision Pro Audio Spectrum 16 (PAS). An old and
>>> rather quirky ISA card, but one that does have particularly decent
>>> audio quality; much better then the usual ISA soundblaster[-clones]
>>> anyways. As such, some people might grumble a bit if Linux support for
>>> it was completely dropped.
>>>
>>> The ALSA project seems rather set on "no documentation == no driver"
>>> and seeing as how Media Vision (and its successor company, the name of
>>> which I have now forgotten; it was bought out by creative labs) is out
>>> of business and how I've never seen a PAS datasheet "out in the wild"
>>> getting ALSA support for this and perhaps other such older hardware
>>> could prove troublesome still ...
>>
>> Bring this up on the kernel list.
>> *someone* must still have documentation for this beast.

My own PAS16 sports the following chips (may have misidentified their 
function):

MV Spectrum MVD101D - Multimedia controller (native interface)
MV Spectrum MVA416  - PCM
MV Spectrum MVA508  - Mixer
MV Thunder  MVD201A - SB Pro compatible part

and a 28MHz oscilator (which is I believe relevant since not all PASs use the 
same clock or something)

Note: the PAS16 is not SB Pro compatible, it just /has/ an SB Pro compatible 
part; with the current OSS drivers you get /dev/{audio,dsp,mixer}{0,1} with 0 
being the native PAS16 stuff and, unless you disable it, 1 the SBP stuff

The card's quirky in that it doesn't seem to (directly, natively) support a 
44100 sampling rate; I had to resample to a supported rate to get it to 
produce something audible under Linux. The Windows driver seems to compensate 
for that automagically (and has that "28MHz clock source" as a driver 
option). Simply catting an .au to /dev/audio0 does let Linus pronounce Linux 
(in both Swedish and English) though.

Rene.
