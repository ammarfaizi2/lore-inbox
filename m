Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312455AbSDNUhq>; Sun, 14 Apr 2002 16:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312457AbSDNUhp>; Sun, 14 Apr 2002 16:37:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39431 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312455AbSDNUho>; Sun, 14 Apr 2002 16:37:44 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: nanosleep
Date: 14 Apr 2002 13:37:22 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a9cpa2$36i$1@cesium.transmeta.com>
In-Reply-To: <20020410055708.9474.qmail@fastermail.com> <1018418496.903.228.camel@phantasy> <20020413145306.A29006@ecam.san.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020413145306.A29006@ecam.san.rr.com>
By author:    andrew may <acmay@acmay.homeip.net>
In newsgroup: linux.dev.kernel
> 
> Make all your calls to nanasleep be less than 2ms, and loop through as
> many as you need until you are under 2ms.
> 
> Don't do it for too long because you get no other use out of your machine
> while your doing this but it does work.
> 

If you want to busy-wait, you might as well do it in userspace (use
RDTSC.)

Maybe a future version of the kernel will have more flexible
scheduling.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
