Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280190AbRKEEDd>; Sun, 4 Nov 2001 23:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280191AbRKEEDN>; Sun, 4 Nov 2001 23:03:13 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:20998 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S280190AbRKEEDH>;
	Sun, 4 Nov 2001 23:03:07 -0500
Message-Id: <5.1.0.14.0.20011105144855.01f83310@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 05 Nov 2001 15:03:02 +1100
To: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
From: Stuart Young <sgy@amc.com.au>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <Pine.GSO.4.21.0111041450410.21449-100000@weyl.math.psu.edu
 >
In-Reply-To: <20011104204502.O14001@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:52 PM 4/11/01 -0500, Alexander Viro wrote:
>Would the esteemed sir care to check where these cycles are spent?
>How about "traversing page tables of every damn process out there"?
>Doesn't sound like a string operation to me...

Just a quickie....

Any reason we can't move all the process info into something like 
/proc/pid/* instead of in the root /proc tree?

Should be pretty easy to do, could still have the pid's in the root /proc 
tree, and if they get read, do what /proc/pci does, and log a warning about 
"xxx is using old /proc interfaces". Makes it just that little bit easier 
to parse processes without fiddling around if you know all the dir's are 
always processes. It's also a bit of a visual cleanup when you have lots of 
processes and do a 'ls /proc'.

There is probably a few other things in /proc/* that could be moved out and 
put in more sensible places (eg: interrupts, irq, devices, mtrr, slabinfo, 
mounts, modules, stat, etc), that really define what they belong to (a 
/proc/kernel/* mebbe). Having /proc basically full of directories would 
clean things up a bit. Some things don't need to change though (eg: uptime, 
version).


AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

