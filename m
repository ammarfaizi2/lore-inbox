Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130235AbQLIHlx>; Sat, 9 Dec 2000 02:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130469AbQLIHlo>; Sat, 9 Dec 2000 02:41:44 -0500
Received: from mx2.core.com ([208.40.40.41]:60833 "EHLO smtp-2.core.com")
	by vger.kernel.org with ESMTP id <S130235AbQLIHl3>;
	Sat, 9 Dec 2000 02:41:29 -0500
Message-ID: <3A31DB5C.F5380C1F@megsinet.net>
Date: Sat, 09 Dec 2000 01:12:28 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Cache problems on test12-pre?
In-Reply-To: <Pine.LNX.4.21.0011022306180.14650-100000@euclid.oak.suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've notices weird compile time failures etc on test12-pre7, especially
running more than 2 simultaneous processes...

but most noticeable is the time it takes to run ldconfig, after the
first time test11 takes less than 1 second, test12-pre7 takes ~40
seconds.

both were run immediately after reboot on a completely idle system
this system is almost exclusively NFS mounted file systems.

Is this a known problem?

Martin

here is test11                  vs               test12-pre7

shadow:~# time ldconfig                      shadow:~# time ldconfig        
 
real    0m35.881s                            real    0m43.979s
user    0m0.120s                             user    0m0.090s
sys     0m0.890s                             sys     0m0.980s
shadow:~# time ldconfig                      shadow:~# time ldconfig
 
real    0m0.870s      <<<<-------->>>>       real    0m38.702s
user    0m0.040s                             user    0m0.120s
sys     0m0.230s                             sys     0m0.980s
shadow:~# time ldconfig                      shadow:~# time ldconfig
 
real    0m0.345s      <<<<-------->>>>       real    0m40.181s
user    0m0.040s                             user    0m0.130s
sys     0m0.070s                             sys     0m0.900s
shadow:~# time ldconfig                      shadow:~# time ldconfig
 
real    0m0.098s      <<<<--------->>>>      real    0m39.108s
user    0m0.050s                             user    0m0.110s
sys     0m0.050s                             sys     0m1.180s
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
