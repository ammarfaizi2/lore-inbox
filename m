Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319040AbSIJGFF>; Tue, 10 Sep 2002 02:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319042AbSIJGFF>; Tue, 10 Sep 2002 02:05:05 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:12979 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319040AbSIJGFE>;
	Tue, 10 Sep 2002 02:05:04 -0400
Date: Tue, 10 Sep 2002 08:09:41 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Rolf Fokkens <fokkensr@fokkensr.vertis.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USER_HZ & NTP problems
Message-ID: <20020910080941.A6298@ucw.cz>
References: <200209092314.g89NEnA05992@fokkensr.vertis.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200209092314.g89NEnA05992@fokkensr.vertis.nl>; from fokkensr@fokkensr.vertis.nl on Tue, Sep 10, 2002 at 01:14:49AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 01:14:49AM +0200, Rolf Fokkens wrote:

> I've been playing with different HZ values in the 2.4 kernel for a while now,
> and apparantly Linus also has decided to introduce a USER_HZ constant (I used
> CLOCKS_PER_SEC) while raising the HZ value on x86 to 1000.
> 
> On x86 timekeeping has shown to be relative fragile when raising HZ (OK, I
> tried HZ=2048 which is quite high) because of the way the interrupt timer is
> configured to fire HZ times each second. This is done by configuring a divisor
> in the timer chip (LATCH) which divides a certain clock (1193180) and

Actually, the clock true frequency is 1193181.8 Hz, although most
manuals say 1.19318 MHz, which, because truncating more digits, also
correct. But 1193180 Hz isn't. If you're trying to count the time
correctly, you should better use 1193182 Hz if staying in integers.

-- 
Vojtech Pavlik
SuSE Labs
