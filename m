Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129706AbQKZLyn>; Sun, 26 Nov 2000 06:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129818AbQKZLyd>; Sun, 26 Nov 2000 06:54:33 -0500
Received: from [194.213.32.137] ([194.213.32.137]:772 "EHLO bug.ucw.cz")
        by vger.kernel.org with ESMTP id <S129706AbQKZLyR>;
        Sun, 26 Nov 2000 06:54:17 -0500
Message-ID: <20001124205247.A141@bug.ucw.cz>
Date: Fri, 24 Nov 2000 20:52:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrea Arcangeli <andrea@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kernel_thread bogosity
In-Reply-To: <20001123232333.A6426@bug.ucw.cz> <20001124014830.I1461@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001124014830.I1461@athlon.random>; from Andrea Arcangeli on Fri, Nov 24, 2000 at 01:48:30AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Plus, can someone explain me why it does not need to setup %%ecx with
> > either zero or address of stack?
> 
> Not necessary because a kernel thread never exit from kernel.

How can that work? restore_args ends with iret, anyway, and iret does
reload esp afaics...
								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
