Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVBVUQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVBVUQr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 15:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVBVUQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 15:16:47 -0500
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:49642
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S261225AbVBVUQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 15:16:41 -0500
Message-ID: <421B9317.7000209@ev-en.org>
Date: Tue, 22 Feb 2005 20:16:23 +0000
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
Cc: mlists@danielinux.net, "David S. Miller" <davem@davemloft.net>,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       Carlo Caini <ccaini@deis.unibo.it>,
       Rosario Firrincieli <rfirrincieli@arces.unibo.it>
Subject: Re: [PATCH] TCP-Hybla proposal
References: <200502221534.42948.mlists@danielinux.net> <20050222094219.0a8efbe1@dxpl.pdx.osdl.net>
In-Reply-To: <20050222094219.0a8efbe1@dxpl.pdx.osdl.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> On Tue, 22 Feb 2005 15:34:42 +0100
> Daniele Lacamera <mlists@danielinux.net> wrote:
>>One last note: IMHO we really need a better way to select congestion 
>>avoidance scheme between those available, instead of switching each one 
>>on and off. I.e., we can't say how vegas and westwood perform when 
>>switched on together, can we?
> 
> The protocol choices are mutually exclusive, if you walk through the code
> (or do experiments), you find that that only one gets used.  As part of the
> longer term plan, I would like to:
> 	- have one sysctl
> 	- choice by route and destination
> 	- union for fields in control block

I'm currently working on a patch to make it a single sysctl, I've got it 
working (as in, the kernel doesn't crash). I still need to validate the 
actual implementation.

I'd say the next stage is to merge fields as much as possible.

I doubt the real use of selection by route/dest, all of the high-speed 
protocols (except possibly for TCP-Hybla) are intended for sender-only 
servers who push lots of data and should work in all cases and alongside 
  Reno TCP traffic without undue unfairness.

I hope to finish the clean-up and preparation of H-TCP for inclusion in 
the kernel and can then help with the unionisation.

Baruch
