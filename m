Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293060AbSCJOnd>; Sun, 10 Mar 2002 09:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293064AbSCJOnN>; Sun, 10 Mar 2002 09:43:13 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:50445 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S293060AbSCJOnM>; Sun, 10 Mar 2002 09:43:12 -0500
Date: Sun, 10 Mar 2002 15:42:05 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ben Clifford <benc@hawaga.org.uk>
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
        Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Linux 2.5.5-dj3 - modprobe psmouse
Message-ID: <20020310154205.H13394@ucw.cz>
In-Reply-To: <20020306124741.J6531@suse.de> <Pine.LNX.4.33.0203061653060.2886-100000@barbarella.hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0203061653060.2886-100000@barbarella.hawaga.org.uk>; from benc@hawaga.org.uk on Wed, Mar 06, 2002 at 04:55:49PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2002 at 04:55:49PM -0800, Ben Clifford wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> Another one...
> 
> modprobe psmouse
> 
> doesn't trigger a modprobe of i8042
> 
> I don't know if you think this should happen in kernel code, or if it
> should be in modules.conf...

They don't depend on each other symbol-wise, and psmouse can work with
other i8042-like interfaces (like ct82c710.o or sun8042.o), so it can't
modprobe that automatically. Add the needed lines to your modules.conf.

-- 
Vojtech Pavlik
SuSE Labs
