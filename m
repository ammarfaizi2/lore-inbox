Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291245AbSCHXpZ>; Fri, 8 Mar 2002 18:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291194AbSCHXpQ>; Fri, 8 Mar 2002 18:45:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36614 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291247AbSCHXo5>; Fri, 8 Mar 2002 18:44:57 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Date: 8 Mar 2002 15:44:45 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a6bidd$9nn$1@cesium.transmeta.com>
In-Reply-To: <E16jRAU-0007QU-00@the-village.bc.nu> <20020308225425.772D13FE06@smtp.linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020308225425.772D13FE06@smtp.linux.ibm.com>
By author:    Hubertus Franke <frankeh@watson.ibm.com>
In newsgroup: linux.dev.kernel
> >
> > Can we go to cache line alignment - for an array of locks thats clearly
> > advantageous
> 
> NO and let me explain.
> 
> I would to be able to integrate the lock with the data.
> This is much more cache friendly then putting the lock on a different 
> cacheline.
> 

Not just cache, but programmer-friendly as well.  Data structures
containing locks (sometimes multiple and related) are really the
common case.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
