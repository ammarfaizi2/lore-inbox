Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317378AbSHMFYD>; Tue, 13 Aug 2002 01:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317380AbSHMFYD>; Tue, 13 Aug 2002 01:24:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46598 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317378AbSHMFYD>; Tue, 13 Aug 2002 01:24:03 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [2.6] The List, pass #2
Date: 12 Aug 2002 22:27:43 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aja5cf$5po$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0207311500210.1038-100000@dlang.diginsite.com> <3D49006C.12ABC6FC@aitel.hist.no> <20020803034019.A140@toy.ucw.cz> <3D5233BC.96ABDF73@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3D5233BC.96ABDF73@aitel.hist.no>
By author:    Helge Hafting <helgehaf@aitel.hist.no>
In newsgroup: linux.dev.kernel
> >
> > Why *safer*? Partition (,DHCP,..) code is ran once at boot. It is hard for
> > it to harm security.
> 
> I wouldn't worry about partition detection, but network stuff
> is always risky.  A "bad guy" could listen for DHCP
> and try to fake a response or do a buffer overflow.
> 
> Userspace programs are supposedly easier to fix, and a
> messed-up userspace isn't quite as bad as a messed up kernel
> when an attacker tries to get in.  
> 

Perhaps more relevantly:

a) User-space code is easier to write; consider memory management in
   particular.

b) If the user-space process has gotten compromised or corrupted, it
   still goes away when it exits.  In the kernel, any corruption stays
   around forever.

   -hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
