Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293423AbSCFJr1>; Wed, 6 Mar 2002 04:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292986AbSCFJrS>; Wed, 6 Mar 2002 04:47:18 -0500
Received: from ns.suse.de ([213.95.15.193]:40716 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293204AbSCFJrK>;
	Wed, 6 Mar 2002 04:47:10 -0500
To: Michael Cheung <vividy@justware.co.jp>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: Re[2]: mount -o remount,ro cause error "device is busy"
In-Reply-To: <20020306074908.GA342@matchmail.com>
	<20020306011519.C963@lynx.adilger.int>
	<20020306172418.C8A3.VIVIDY@justware.co.jp>
X-Yow: I just got my PRINCE bumper sticker..
 But now I can't remember WHO he is...
From: Andreas Schwab <schwab@suse.de>
Date: Wed, 06 Mar 2002 10:47:02 +0100
In-Reply-To: <20020306172418.C8A3.VIVIDY@justware.co.jp> (Michael Cheung's
 message of "Wed, 06 Mar 2002 17:33:45 +0900")
Message-ID: <jeadtmgh9l.fsf@sykes.suse.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.2.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Cheung <vividy@justware.co.jp> writes:

|> hi,
|> 
|> maybe i am wrong, but I really can't find any other process runing.
|> 
|> my step is:
|> 1) "/" and "/usr" are busy
|> 2) shut down to single user mode
|> 3) "/" still busy
|> 4) "/usr" can be unmounted, but can't mount -o ro,remount /usr, show busy error.
|> 5) umount -a, after this, only /proc and / exist.
|> 6) mount -o ro,remount /, show busy error.
|> 
|> I have mentioned I have used "ps aux" to check the process list,
|> there are no user process left. except the following: (repost)
|> root         1  0.1  0.7  1056  484 ?        S    15:46   0:04 init [S] 
|> root         2  0.0  0.0     0    0 ?        SW   15:46   0:00 [keventd]
|> root         3  0.0  0.0     0    0 ?        SWN  15:46   0:00 [ksoftirqd_CPU0]
|> root         4  0.0  0.0     0    0 ?        SW   15:46   0:00 [kswapd]
|> root         5  0.0  0.0     0    0 ?        SW   15:46   0:00 [bdflush]
|> root         6  0.0  0.0     0    0 ?        SW   15:46   0:00 [kupdated]
|> root      1042  0.0  0.7  1056  484 tty1     S    16:33   0:00 init [S] 
|> root      1043  0.6  1.5  1840 1004 tty1     S    16:33   0:00 /bin/sh
|> root      1045  0.0  1.0  2260  680 tty1     R    16:33   0:00 ps aux
|> 
|> and I also checked by fuser -v /usr,
|> only used by kernel.
|> and fuser -c /, show many process list above.
|> 
|> If i have a mistake, would you like to tell me where is the mistake?

Check for references to deleted files (/proc/*/fd).  "init u" should help.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE GmbH, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
