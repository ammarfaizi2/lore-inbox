Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291693AbSBNO4i>; Thu, 14 Feb 2002 09:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291707AbSBNO42>; Thu, 14 Feb 2002 09:56:28 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:50120 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S291693AbSBNO4N>; Thu, 14 Feb 2002 09:56:13 -0500
Date: Thu, 14 Feb 2002 08:56:10 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200202141456.IAA24921@tomcat.admin.navo.hpc.mil>
To: mtoseland@cableinet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Fun with OOM on 2.4.18-pre9
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

toad <mtoseland@cableinet.co.uk>:
> 
> I do a make -j bzImage
> I have 2 large processes (Kaffe) running in the background. They are
> driven by scripts like this:
> 
> while true;
> do su freenet -c java freenet.node.Main;
> done
> 
> I have 512MB of RAM and no swap on 2.4.18-pre9.
> Kernel eventually slows to a near complete halt, and starts killing
> processes.
> It kills Kaffe several times
> Out of Memory: Killed process xyz (Kaffe)
> (no I don't have logs, sorry)
> Each time it's a different pid, having respawned from its parent
> process. Then later, it apparently becomes unkillable - each time it
> respawns it is *the same PID*. VT switching works, but otherwise the
> system is unresponsive. It is not clear whether the make -j is still
> running. Immediately before this, it did the same thing with dictd, but
> eventually got around to Kaffe. After a fairly long wait I rebooted with
> the reset switch.
> 
> Any more information useful? Is this known behaviour?

Known behaviour - ie. don't do that.

On most systems a "make -j4", or 6, or even 8 will work. But SOMETHING has
to give after memory fills up. The number of processes to use for -j
depends on the system. On mine (256MB, dual pentium pro) I don't do more
than 6, and 4 works best (lets me run solitare too).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
