Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318818AbSHLU2T>; Mon, 12 Aug 2002 16:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318819AbSHLU2T>; Mon, 12 Aug 2002 16:28:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53009 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318818AbSHLU2S>; Mon, 12 Aug 2002 16:28:18 -0400
Date: Mon, 12 Aug 2002 13:32:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Robert Love <rml@tech9.net>, Skip Ford <skip.ford@verizon.net>,
       "Adam J. Richter" <adam@yggdrasil.com>, <ryan.flanigan@intel.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.31: modules don't work at all
In-Reply-To: <3D57F5D6.C54F5A2A@zip.com.au>
Message-ID: <Pine.LNX.4.33.0208121330310.1289-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Aug 2002, Andrew Morton wrote:
> 
> Gets tricky with nested lock_kernels.

No, lock-kernel already only increments once, at the first lock_kernel. We 
have a totally separate counter for the BKL depth, see <asm/smplock.h>

		Linus

