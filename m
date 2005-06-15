Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVFONoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVFONoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 09:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVFONoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 09:44:32 -0400
Received: from pop.gmx.net ([213.165.64.20]:17588 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261428AbVFONo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 09:44:29 -0400
X-Authenticated: #137701
From: Alexander Gretencord <arutha@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Swapping in 2.6.10 and 2.6.11.11 on a desktop system
Date: Wed, 15 Jun 2005 15:44:16 +0200
User-Agent: KMail/1.8.1
Cc: Con Kolivas <kernel@kolivas.org>
References: <200506141653.32093.arutha@gmx.de> <200506150242.02606.kernel@kolivas.org>
In-Reply-To: <200506150242.02606.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506151544.17191.arutha@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 June 2005 18:42, Con Kolivas wrote:
> Try the mapped watermark patch from -ck on 2.6.11*

Unfortunately this patch does not help either. The patch buys me time but then 
I get swapping at the 300MB mark. 2.6.8.1 with swappiness=0 swaps later than 
this...

These are 'free -m' statistics a minute after reaching the 300MB mark:

             total       used       free     shared    buffers     cached
Mem:           503        498          5          0         36        376
-/+ buffers/cache:         85        418
Swap:          494        227        266

Why does the kernel think that I need 400MB of disk cache when I start some 
memory hungry apps? Can't we have a hard limit on disk cache, like: "Don't 
use more than 100MB of disk cache".

The problem seems to be that instead of using a big disk cache when theres 
plenty of ram and reducing disk cache when applications need the ram, the 
disk cache shrinks until a magic watermark and then grows and grows until 
theres no ram left for the applications. At least thats the behaviour I am 
seeing.


Alex

P.S.: Please cc me as I'm not on the list.
