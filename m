Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129842AbRABWGY>; Tue, 2 Jan 2001 17:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131171AbRABWGO>; Tue, 2 Jan 2001 17:06:14 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:3297 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129842AbRABWF7>; Tue, 2 Jan 2001 17:05:59 -0500
To: Gregory McLean <gregm@comstar.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-prerelease shmget woes.
In-Reply-To: <Pine.LNX.4.30.0101011429380.1416-100000@tweetie.comstar.net>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <Pine.LNX.4.30.0101011429380.1416-100000@tweetie.comstar.net>
Message-ID: <m3n1d9wu49.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 02 Jan 2001 22:38:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory McLean <gregm@comstar.net> writes:
> cat /proc/sys/kernel/shmall
> 0

That's your problem. Your limit for overall shm pages is zero. So you
cannot allocate any shm segments.

echo 2000000 > /proc/sys/kernel/shmall

and check /etc/sysctl.conf or wherever your system stores kernel
parameters to restore on boot.

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
