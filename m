Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130887AbQLHBkH>; Thu, 7 Dec 2000 20:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130695AbQLHBj5>; Thu, 7 Dec 2000 20:39:57 -0500
Received: from unknown-51-46.wrs.com ([147.11.51.46]:60945 "HELO
	Whinham.wrs.com") by vger.kernel.org with SMTP id <S129831AbQLHBjs>;
	Thu, 7 Dec 2000 20:39:48 -0500
Date: Thu, 7 Dec 2000 17:09:19 -0800
From: Michel LESPINASSE <walken@zoy.org>
To: Rainer Mager <rmager@vgkk.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Signal 11
Message-ID: <20001207170919.B9121@windriver.com>
In-Reply-To: <E144BOL-0003Eg-00@the-village.bc.nu> <NEBBJBCAFMMNIHGDLFKGMEFHCIAA.rmager@vgkk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGMEFHCIAA.rmager@vgkk.com>; from rmager@vgkk.com on Fri, Dec 08, 2000 at 09:44:29AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000 at 09:44:29AM +0900, Rainer Mager wrote:

> 	I've heard that signal 11 can be related to bad hardware, most
> often memory, but I've done a good bit of testing on this and the
> system seems ok.  What I did was to run the VA Linux Cerberos(sp?)
> test for 15 hours+ with no errors. Actually this only worked when
> running from the console. When running from X the machine locked up
> (although no signal 11).

Don't be so quick to dismiss the "bad hardware" possibility. It is
really quite common these days. And, some cases of bad hardware are
not detected using simple tests like memtest86. (I'm not sure exactly
what cerberos does, do you have a link for it ?).

My recommandation would be to take a big source tree (say, a bit
bigger than the amount of RAM you have), and run repetitive
tar+detar+diff -ru runs on it for 48 hours or so. If your hardware
runs OK, diff should not report any inconsistencies. I found this test
to be quite reliable to detect hardware problems. If you have several
disk controllers, run one instance of the test on each of
them. Additionally you could run a background task to keep the CPU at
100% - a simple while 1 loop would do.

-- 
Michel "Walken" LESPINASSE
Of course I think I'm right. If I thought I was wrong, I'd change my mind.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
