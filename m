Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262695AbTCYQAY>; Tue, 25 Mar 2003 11:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262703AbTCYQAX>; Tue, 25 Mar 2003 11:00:23 -0500
Received: from zork.zork.net ([66.92.188.166]:24229 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S262695AbTCYQAW>;
	Tue, 25 Mar 2003 11:00:22 -0500
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.66: task_struct memory leak?
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: GRAVE ILL-JUDGEMENT, ADULT
 LANGUAGE/SITUATIONS
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Date: Tue, 25 Mar 2003 16:11:32 +0000
In-Reply-To: <20030325155104.B24418@flint.arm.linux.org.uk> (Russell King's
 message of "Tue, 25 Mar 2003 15:51:04 +0000")
Message-ID: <6usmtbe897.fsf@zork.zork.net>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) Emacs/21.2 (gnu/linux)
References: <20030325155104.B24418@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Russell King quotation:

> I'm seeing memory disappear at a rate of 8K / process, which seems to
> suggest that the ARM level 1 page tables aren't getting freed either.
>
> Is anyone seeing this type of behaviour on x86?

Running 2.5.66 (plus Ingo Molnar's sched-2.5.66-A2), and I don't seem
to see a growth in the task_struct slab after repeated forking:

$ grep task_struct /proc/slabinfo ; for i in $(seq 1000) ; do /bin/true ; done ; grep task_struct /proc/slabinfo
task_struct           79     80   1552   16   16    2 :   54   27
task_struct           79     80   1552   16   16    2 :   54   27

-- 
Sean Neakums - <sneakums@zork.net>
