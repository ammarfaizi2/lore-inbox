Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281657AbRLDDso>; Mon, 3 Dec 2001 22:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283024AbRLCXpF>; Mon, 3 Dec 2001 18:45:05 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:59520 "EHLO
	Elf.ucw.cz") by vger.kernel.org with ESMTP id <S285319AbRLCWu2>;
	Mon, 3 Dec 2001 17:50:28 -0500
Date: Mon, 3 Dec 2001 21:04:42 +0100
From: Pavel Machek <pavel@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011203210442.A248@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.10.10111261229190.8817-100000@master.linux-ide.org> <01112715312104.01486@localhost> <20011128194302.A29500@emma1.emma.line.org> <01112813462404.01163@driftwood> <20011128231925.A7034@emma1.emma.line.org> <20011129232157.A211@elf.ucw.cz> <20011202010823.A5653@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011202010823.A5653@emma1.emma.line.org>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Drives should never reassign blocks on read operations, because they'd
> > > take away the chance to try to read that block for say four hours.
> > 
> > Why not? If drive gets ECC-correctable read error, it seems to me like
> > good time to reassign.
> 
> Because you don't know if it's just some slipped bits, a shutdown during
> write, or an actual fault. When that happens on a verify after write,
> that's indeed reasonable. Otherwise the drive should just mark that
> block as "watch closely on next write".

Or better "write back and verify". You do not want even *ECC
correctable* errors to be on your platters.
								Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
