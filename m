Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291084AbSBRSme>; Mon, 18 Feb 2002 13:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290811AbSBRSjG>; Mon, 18 Feb 2002 13:39:06 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:1285 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S289874AbSBRS3Z>;
	Mon, 18 Feb 2002 13:29:25 -0500
Date: Mon, 18 Feb 2002 00:10:48 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: mtoseland@cableinet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Fun with OOM on 2.4.18-pre9
Message-ID: <20020217231048.GA527@elf.ucw.cz>
In-Reply-To: <200202141456.IAA24921@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202141456.IAA24921@tomcat.admin.navo.hpc.mil>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I do a make -j bzImage
> > I have 2 large processes (Kaffe) running in the background. They are
> > driven by scripts like this:
> > 
> > while true;
> > do su freenet -c java freenet.node.Main;
> > done
> > 
> > I have 512MB of RAM and no swap on 2.4.18-pre9.
> > Kernel eventually slows to a near complete halt, and starts killing
> > processes.
> > It kills Kaffe several times
> > Out of Memory: Killed process xyz (Kaffe)
> > (no I don't have logs, sorry)
> > Each time it's a different pid, having respawned from its parent
> > process. Then later, it apparently becomes unkillable - each time it
> > respawns it is *the same PID*. VT switching works, but otherwise the
> > system is unresponsive. It is not clear whether the make -j is still
> > running. Immediately before this, it did the same thing with dictd, but
> > eventually got around to Kaffe. After a fairly long wait I rebooted with
> > the reset switch.
> > 
> > Any more information useful? Is this known behaviour?
> 
> Known behaviour - ie. don't do that.

No, it should *kill* kaffe, not only say it is doing that.
									Pavel

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
