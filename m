Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291232AbSBQWtC>; Sun, 17 Feb 2002 17:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291233AbSBQWsx>; Sun, 17 Feb 2002 17:48:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1040 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291232AbSBQWsj>; Sun, 17 Feb 2002 17:48:39 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Missed jiffies
Date: 17 Feb 2002 14:48:18 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a4pbvi$iq2$1@cesium.transmeta.com>
In-Reply-To: <3C6E77DE.70FE49DF@rwii.com> <3C6E833F.1A888B3C@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3C6E833F.1A888B3C@mvista.com>
By author:    george anzinger <george@mvista.com>
In newsgroup: linux.dev.kernel
> 
> One of the nasty problems, especially with machines such as yours (i.e.
> lap tops), is the fact that TSC is NOT clocked at a fixed rate.  It is
> affected by throttling (reduced in 12.5% increments) and by power
> management.

If the TSC is affected by HLT, throttling, or C2 power management, the
TSC is broken (as it is on Cyrix chips, for example.)  The TSC usually
*is* affected by C3 power management, but the OS should be aware of
C3.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
