Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318987AbSH1Vfk>; Wed, 28 Aug 2002 17:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318988AbSH1Vfk>; Wed, 28 Aug 2002 17:35:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33293 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318987AbSH1Vfk>; Wed, 28 Aug 2002 17:35:40 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: atomic64_t proposal
Date: 28 Aug 2002 14:39:28 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <akjfug$o47$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0208281040010.14946-100000@rmholt.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0208281040010.14946-100000@rmholt.homeip.net>
By author:    Robin Holt <holt@rmholt.homeip.net>
In newsgroup: linux.dev.kernel
> 
> I do like the atomic_inc, atomic_dec, etc being able to handle either 
> type.  While producing code, I can do a simple check at the beginning of 
> the block and define the appropriate type for a particular architecture.
> 

Great.  How do you expect to implement atomic_inc() et al so that that
can actually be done?  Consider that atomic64_t may very well need
full-blown spinlocks, whereas a 32-bit atomic_t may not.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
