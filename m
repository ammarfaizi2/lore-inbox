Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290843AbSBLJH6>; Tue, 12 Feb 2002 04:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290841AbSBLJHs>; Tue, 12 Feb 2002 04:07:48 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:18953 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290839AbSBLJHl>;
	Tue, 12 Feb 2002 04:07:41 -0500
Date: Mon, 11 Feb 2002 21:15:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Internal compiler error in 2.4.5 (hacky workaround)
Message-ID: <20020211201505.GA9922@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This makes gcc survive... adding volatile everywhere ;-).

int blk_ioctl(volatile kdev_t dev, volatile unsigned int cmd, volatile
unsigned long arg)
{
        volatile request_queue_t *q;
        volatile struct gendisk *g;
        volatile u64 ullval = 0;
        volatile int intval, *iptr;
        volatile unsigned short usval;

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
