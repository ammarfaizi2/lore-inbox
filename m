Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbVIGMoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVIGMoh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 08:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVIGMoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 08:44:37 -0400
Received: from rain.plan9.de ([193.108.181.162]:53148 "EHLO rain.plan9.de")
	by vger.kernel.org with ESMTP id S932131AbVIGMoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 08:44:37 -0400
Date: Wed, 7 Sep 2005 14:44:35 +0200
From: Marc Lehmann <schmorp@schmorp.de>
To: linux-kernel@vger.kernel.org
Subject: Re: masquerading failure for at least icmp and tcp+sack on amd64
Message-ID: <20050907124435.GA576@schmorp.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050906172930.GA29753@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906172930.GA29753@schmorp.de>
X-PGP: "1024D/DA743396 1999-01-26 Marc Alexander Lehmann <schmorp@schmorp.de>
       Key fingerprint = 475A FE9B D1D4 039E 01AC  C217 A1E8 0270 DA74 3396"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 07:29:30PM +0200, Marc Lehmann <schmorp@schmorp.de> wrote:
> Weird obervation 2:
> 
> Some sites could be connected to with TCP. It turned out that those
> sites did not support TCP SACK. Indeed, turning off SACK either on the
> remote side of a connection or on the origonator side resulted in workign
> masquerading:

Sorry for the F'up, but this turned to be slightly untrue: turning off SACK
makes the syn handshake happen, but some packets further down the stream
the masquerading router sends a RST again.

> Kernels that don't work:
> 
>    2.6.13-rc7 (compiled with gcc-3.4 and 4.0.2 debian), 2.6.13 (gcc-4.02)
> 

I forgot to mention that the kernels that don't work are for amd64. In
the meantime, I also tried out 2.6.11 (as I had some troubles with
2.6.12..2.6.13-rc7 on other amd64 machines), with the same result (reply
packets are ignored/rejected).

-- 
                The choice of a
      -----==-     _GNU_
      ----==-- _       generation     Marc Lehmann
      ---==---(_)__  __ ____  __      pcg@goof.com
      --==---/ / _ \/ // /\ \/ /      http://schmorp.de/
      -=====/_/_//_/\_,_/ /_/\_\      XX11-RIPE
