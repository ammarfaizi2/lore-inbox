Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314043AbSEMPYT>; Mon, 13 May 2002 11:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314058AbSEMPYS>; Mon, 13 May 2002 11:24:18 -0400
Received: from bgp401130bgs.jersyc01.nj.comcast.net ([68.36.96.125]:27406 "EHLO
	buggy.badula.org") by vger.kernel.org with ESMTP id <S314043AbSEMPYR>;
	Mon, 13 May 2002 11:24:17 -0400
Date: Mon, 13 May 2002 11:24:10 -0400
Message-Id: <200205131524.g4DFOAc30622@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Stig Brautaset <stigbrau@start.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: xircom nic itch (drops ip)
In-Reply-To: <20020512214217.GA19727@brautaset.org>
User-Agent: tin/1.5.11-20020130 ("Toxicity") (UNIX) (Linux/2.4.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002 22:42:18 +0100, Stig Brautaset <stigbrau@start.no> wrote:

> My pcmcia network card drops its ip from time to time. This happens
> frequently enough for it to be rather annoying, but not frequently to be
> really annoying. It seems to happen when there is no traffic through
> the link (based on the fact that I cannot ever remember it happening
> while I was on irc ;).

Are you using dhcp on that interface? If so, what happens to the dhcp 
client daemon when the interface 'loses' the ip? Is it logging anything?
Is it dying?

If you're not using dhcp, I'm a little stumped..

> The card is a Xircom Cardbus 10/100 NIC (CBEM56G-100), and it use the
> kernel's xircom_cb module. I used to use the module in the pcmcia_cs
> package before, but I can't remember whether it was any better then (I
> don't think it was though).

You could try to use the xircom_tulip_cb module instead, and see if it
solves the problem. I don't think it will, but who knows.

Despite what Configure.help says, xircom_tulip_cb is actually better
than xircom_cb. The latter should only be used if xircom_tulip_cb
has problems -- I haven't heard of any recently, but I do want to hear
about them if they still exist.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
