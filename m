Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282843AbSBISfQ>; Sat, 9 Feb 2002 13:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282845AbSBISfG>; Sat, 9 Feb 2002 13:35:06 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:2829 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S282843AbSBISfD>;
	Sat, 9 Feb 2002 13:35:03 -0500
Date: Sat, 9 Feb 2002 19:35:00 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Pavel Machek <pavel@suse.cz>, Dave Jones <davej@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>, vojtech@ucw.cz,
        andre@linuxdiskcert.org
Subject: Re: ide cleanup
Message-ID: <20020209193500.A18944@suse.cz>
In-Reply-To: <20020206205332.GA3217@elf.ucw.cz> <Pine.LNX.3.96.1020209131726.23246D-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1020209131726.23246D-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Sat, Feb 09, 2002 at 01:19:58PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2002 at 01:19:58PM -0500, Bill Davidsen wrote:
> On Wed, 6 Feb 2002, Pavel Machek wrote:
> 
> > -#ifdef CONFIG_BLK_DEV_PDC4030
> >  	if (IS_PDC4030_DRIVE) {
> >  		extern ide_startstop_t promise_rw_disk(ide_drive_t *, struct request *, unsigned long);
> >  		return promise_rw_disk(drive, rq, block);
> >  	}
> > -#endif /* CONFIG_BLK_DEV_PDC4030 */
> 
> Am I reading this totally wrong, or do you really think it's a good idea
> to test for a drive even if the user didn't configure such hardware?

Well, since IS_PDC4030_DRIVE will always be 0 in that case, the test
will be optimized out ...

-- 
Vojtech Pavlik
SuSE Labs
