Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130457AbRCLPtJ>; Mon, 12 Mar 2001 10:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130466AbRCLPs7>; Mon, 12 Mar 2001 10:48:59 -0500
Received: from james.kalifornia.com ([208.179.59.2]:62780 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S130457AbRCLPsq>; Mon, 12 Mar 2001 10:48:46 -0500
Message-ID: <3AACEFAA.6D93FD9F@kalifornia.com>
Date: Mon, 12 Mar 2001 07:47:54 -0800
From: David Ford <david@kalifornia.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: curious bug
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.3-pre3

richh    12557  0.0  0.7  5096 1704 pts/10   D    04:32   0:00 ./egg
idaho
richh    12558  0.0  0.0     0    0 pts/10   Z    04:32   0:00 [egg
<defunct>]
richh    12560  0.0  0.7  5096 1704 pts/10   S    04:32   0:00 ./egg
idaho

# ps -eo args,wchan|grep egg
./egg idaho      down
[egg <defunct>]  do_exit
./egg idaho      rt_sigsuspend

kill -9 had no effect on 12557 until i killed 12560.  this D state
process held the load at 1.01 for hours.

any takers?

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



