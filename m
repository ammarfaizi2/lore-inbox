Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265798AbTBCANk>; Sun, 2 Feb 2003 19:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbTBCANk>; Sun, 2 Feb 2003 19:13:40 -0500
Received: from evil.netppl.fi ([195.242.209.201]:14556 "EHLO evil.netppl.fi")
	by vger.kernel.org with ESMTP id <S265798AbTBCANk>;
	Sun, 2 Feb 2003 19:13:40 -0500
Date: Mon, 3 Feb 2003 02:23:02 +0200
From: Pekka Pietikainen <pp@netppl.fi>
To: Carlos Velasco <carlosev@newipnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 Broken Path MTU Discovery?
Message-ID: <20030203002302.GA32336@netppl.fi>
References: <200302021958160177.2A4B5622@192.168.128.16> <200302030108240978.2B66BB7E@192.168.128.16>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200302030108240978.2B66BB7E@192.168.128.16>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 01:08:24AM +0100, Carlos Velasco wrote:
> *Info added*
> 
> This issue is not shown when MTU in router is 600 or bigger.
> If I set router MTU to 500 the problem is as show below.
See /proc/sys/net/ipv4/route/min_pmtu, which defaults to 552. 

And there's a perfectly good reason to have a minimum value,
guess what happens if someone starts spoofing fragmentation needed
packets that suggest a MTU of 68 bytes would be appropriate?
