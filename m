Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317876AbSHDPyz>; Sun, 4 Aug 2002 11:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317877AbSHDPyz>; Sun, 4 Aug 2002 11:54:55 -0400
Received: from mailrelay.nefonline.de ([212.114.153.196]:4109 "EHLO
	mailrelay.nefonline.de") by vger.kernel.org with ESMTP
	id <S317876AbSHDPyy>; Sun, 4 Aug 2002 11:54:54 -0400
Message-Id: <200208041558.RAA32583@myway.myway.de>
From: "Daniela Engert" <dani@ngrt.de>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "alien.ant@ntlworld.com" <alien.ant@ntlworld.com>
Cc: "Alex Davis" <alex14641@yahoo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Sun, 04 Aug 2002 17:58:23 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.20.2200 for OS/2 Warp 4.05
In-Reply-To: <1028480553.14195.35.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: 2.4.19 IDE Partition Check issue
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 Aug 2002 18:02:33 +0100, Alan Cox wrote:

>On Sun, 2002-08-04 at 16:16, alien.ant@ntlworld.com wrote:
>> Alan - I'm wondering if this issue is related to Maxtor drives? All the
>> reports I have seen of this problem have featured drives from this
>> manufacturer.

>The ALi hang may well be sort of this. If its what Andre thinks then its
>lack of support for LBA48 on ALi interface hardware (or at least for the
>documentation we currently have on how to program it). If so -ac2 should
>sort that one out

ALi IDE controllers up to revision C4h don't support LBA48 in DMA mode,
later revisions can do both PIO and DMA with LBA48 addressing. Check
out ALi's Windows drivers to see how the manufacturer itself worked
around this problem (it's kinda obvious).

Ciao,
  Dani


