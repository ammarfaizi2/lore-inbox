Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274567AbRIVJ2J>; Sat, 22 Sep 2001 05:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274604AbRIVJ17>; Sat, 22 Sep 2001 05:27:59 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:22021 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S274567AbRIVJ1q>; Sat, 22 Sep 2001 05:27:46 -0400
Date: Sat, 22 Sep 2001 11:28:09 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: David Findlay <david_j_findlay@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug: Joystick Driver doesn't talk to CMPCI gameports`
Message-ID: <20010922112809.A2366@suse.cz>
In-Reply-To: <200109220514.f8M5EevF002295@ADSL-Server.davsoft.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109220514.f8M5EevF002295@ADSL-Server.davsoft.com.au>; from david_j_findlay@yahoo.com.au on Sat, Sep 22, 2001 at 03:13:14PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2001 at 03:13:14PM +1000, David Findlay wrote:
> I have a C-Media 8738 card built into my motherboard. The sound works fine.
> 
> I use these command as from the joystick documentation:
> 
> modprobe cmpci joystick=1
> modprobe joydev
> modprobe analog
> 
> I am using DevFS and kernel 2.4.9. Nothing appears in /dev/input where js0 
> should actually appear when I insmod the analog joystick. The results of 
> lsmod after doing those commands:
> 
> Workshop:/dev/input# lsmod
> Module                  Size  Used by
> analog                  6960   0  (unused)
> gameport                1808   0  [analog]
> cmpci                  28416   0
> 
> It appears that instead of using the cmpci gameport, it is using the gameport 
> driver or something. Could someone please help me either get it going if 
> there's a workaround, or otherwise tell me what code to look at to fix it? 
> Thanks,
> 
> David
> 
> P.S. I'm not subscribed so please CC your response to me Thanks,

The cmpci driver still doesn't register a gameport, you need the ns558
module as well.

-- 
Vojtech Pavlik
SuSE Labs
