Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261956AbRESTDW>; Sat, 19 May 2001 15:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261967AbRESTDM>; Sat, 19 May 2001 15:03:12 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:39940 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S261956AbRESTC5>;
	Sat, 19 May 2001 15:02:57 -0400
Message-ID: <20010519205848.A18081@bug.ucw.cz>
Date: Sat, 19 May 2001 20:58:48 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>, viro@math.psu.edu
Subject: mount misbehaviour?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I just had small surprise with 2.4.0:

root@bug:/zip# mount /zip
root@bug:/zip# ls -al
total 8
drwxr-xr-x    2 root     root         4096 Dec  1 08:29 .
drwxr-xr-x   31 65534    root         4096 Apr 24 20:56 ..
root@bug:/zip# cd /zip
root@bug:/zip# ls -al
total 22182
drwxr-xr-x    4 root     root        16384 Jan  1  1970 .
drwxr-xr-x   31 65534    root         4096 Apr 24 20:56 ..
-rw-r--r--    1 root     root     22687788 May 18 11:48 delme.wav
drwxr-xr-x    2 root     root         2048 May 18 11:30 karantena
drwxr-xr-x    5 root     root         2048 May  9 14:15 statnice

...Mounting directory under me does not seem healthy. cd fixes
it... Is that okay?
								Pavel
PS: Al, would you please add credit line for yourselves?

pavel@bug:/usr/src/linux$ grep Viro CREDITS
pavel@bug:/usr/src/linux$ grep Viro MAINTAINERS
pavel@bug:/usr/src/linux$ 

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
