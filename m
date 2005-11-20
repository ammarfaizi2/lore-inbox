Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbVKTOxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbVKTOxO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 09:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVKTOxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 09:53:14 -0500
Received: from herkules.vianova.fi ([194.100.28.129]:43994 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S1751236AbVKTOxN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 09:53:13 -0500
Date: Sun, 20 Nov 2005 16:53:09 +0200
From: Ville Herva <vherva@vianova.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Upgrade 2.6.12-rc4 -> 2.6.13.1 broke DVD-R writing (fails consistenly in OPC phase)
Message-ID: <20051120145308.GC22255@vianova.fi>
Reply-To: vherva@vianova.fi
References: <20050925123049.GA24760@viasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050925123049.GA24760@viasys.com>
X-Operating-System: Linux herkules.vianova.fi 2.4.32-rc1
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2005 at 03:30:49PM +0300, you [Ville Herva] wrote:
> After I upgraded from 2.6.12-rc4 to 2.6.13.1, I can no longer write DVD-R
> (haven't tried DVD+R nor CD-R). 
> 
> The command 
> 
>  growisofs -r -l -J -R -f -graft-points ${=FILES} -Z /dev/hdc
> 
> always gives:
> 
>  :-[ PERFORM OPC failed with SK=3h/ASC=73h/ACQ=03h]: Input/output error
> 
> Nothing relevant in dmesg.
> 
> The drive is Optoride DVD±RW DD0401, the medium is Verbatim DVD-R 8x, and
> the chipset is i815; Celeron Tualatin 1.4GHZ; Abit ST6R.
> 
> I tried the growisofs command probably a dozen times, rebooted and powered
> off in the middle¹. I tried a couple of other discs from the same ("known
> good") batch. cdrecord also fails. I tried to set -speed=1, 2, 4, but
> growisofs claims setting speed to anything but 8x does not succeed.
> 
> The drive is able to read CD and DVD media just fine with 2.6.13.1.
> 
> I booted back to 2.6.12-rc4 and the recording succeeded at the first try. I
> used the exact same disc that had failed with 2.6.13.1.

This still happens with 2.6.14-rc2.

I found a work-around, though. It seems this happens every time I rip an
audio cd and then try to burn a dvd. If I mount a data cd in between, it
seems to work. It seems even a soft reboot is not always enough to clear
problem. 

What is curious, though, is that 2.6.12-rc4 and earlier newer seemed to show
this. With 2.6.13.1 and newer it seems fairly consistent.



-- v -- 

v@iki.fi

