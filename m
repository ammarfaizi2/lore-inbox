Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311046AbSCHTVJ>; Fri, 8 Mar 2002 14:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311045AbSCHTU7>; Fri, 8 Mar 2002 14:20:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17160 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311039AbSCHTUx>; Fri, 8 Mar 2002 14:20:53 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Interprocess shared memory .... but file backed?
Date: 8 Mar 2002 11:20:15 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a6b2tf$ut6$1@cesium.transmeta.com>
In-Reply-To: <E16jMMJ-0006V3-00@the-village.bc.nu> <3C88D930.2080308@htec.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3C88D930.2080308@htec.demon.co.uk>
By author:    Christopher Quinn <cq@htec.demon.co.uk>
In newsgroup: linux.dev.kernel
>
> > well MAP_PRIVATE is "dont share" so not with that 8)
> > Use MAP_SHARED and you'll get what you want
> > 
> Certainly true! But MAP_SHARED gives uncontrolled flush of 
> dirty data - so that's out for me. I only want 'privacy' to 
> extend to the right to make changes permanent at my own 
> discretion.
> 

I actually have this issue as well, in order to make LPSM sharable it
would be greatly beneficial to have something that would allow
multiple processes to see the same mmap, but for writes not to hit the
backing store file.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
