Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278163AbRJWSOf>; Tue, 23 Oct 2001 14:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278160AbRJWSOZ>; Tue, 23 Oct 2001 14:14:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28435 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278163AbRJWSOO>; Tue, 23 Oct 2001 14:14:14 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Q] pivot_root and initrd
Date: 23 Oct 2001 11:14:28 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9r4c24$g2k$1@cesium.transmeta.com>
In-Reply-To: <3BD5ABF3.1040404@usa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3BD5ABF3.1040404@usa.net>
By author:    Eric <ebrower@usa.net>
In newsgroup: linux.dev.kernel
>
> Would it even be worthwhile to propose a patch that would set a flag 
> when pivot_root is called during an initrd and prevent change_root from 
> occuring once the linuxrc thread exits?
> 
> Your method of placing "initrx=xxx" and "root=xxx" is similar to my 
> method of stuffing those values into /proc/sys/kernel/real_root_dev once 
> the pivot_root is complete; I am not really happy with that solution, 
> not the least of which because it is an undocumented work-around and 
> somewhat unexpected behavior for a system call that is to (presumably) 
> replace or augment change_root.
> 
> I was also hoping that Warner or Hans would chime-in either in defense 
> of the current documentation or with clarifications...
> 

The right thing is to get rid of the old initrd compatibility cruft,
but that's a 2.5 change.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
