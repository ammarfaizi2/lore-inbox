Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129515AbQJ1HCV>; Sat, 28 Oct 2000 03:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130113AbQJ1HCA>; Sat, 28 Oct 2000 03:02:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13317 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129515AbQJ1HB6>;
	Sat, 28 Oct 2000 03:01:58 -0400
Date: Sat, 28 Oct 2000 00:04:48 -0700
From: Jens Axboe <axboe@suse.de>
To: Hisaaki Shibata <shibata@luky.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch: atapi dvd-ram support
Message-ID: <20001028000448.D3919@suse.de>
In-Reply-To: <20001024162112.A520@suse.de> <20001028141056T.shibata@luky.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28 2000, Hisaaki Shibata wrote:
> I did patch 2.2.17 tree with dvd-ram-2217p17.diff.bz2.
> 
> At that time, following patch is rejected.
> I think these lines should be removed from patchs.
> 
> 	@@ -1329,7 +1369,7 @@
> 	 static
> 	  void cdrom_sleep (int time)
> 	   {
> 	   -       current->state = TASK_INTERRUPTIBLE;
> 	   +       __set_current_state(TASK_INTERRUPTIBLE);
> 	           schedule_timeout(time);
> 	    }
> 
> After removing these, I could make bzImage.

Weird, should not reject. Oh well.

> But I could not mkudf nor mkext2fs to my ATAPI 9.4GB new DVD-RAM drive.

What do you mean? What happened? strace of mke2fs of mkudf would
be nice to have.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
