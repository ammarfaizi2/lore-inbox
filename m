Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129156AbRDGS1m>; Sat, 7 Apr 2001 14:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129164AbRDGS1c>; Sat, 7 Apr 2001 14:27:32 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:34826 "HELO
	mail11.speakeasy.net") by vger.kernel.org with SMTP
	id <S129156AbRDGS1U>; Sat, 7 Apr 2001 14:27:20 -0400
Message-ID: <3ACF5C31.B3B0594F@megapathdsl.net>
Date: Sat, 07 Apr 2001 11:28:01 -0700
From: Miles Lane <miles@megapathdsl.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.3-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.4.3-ac2 -- How do I determine if shm is being used?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have mounted:

	none on /var/shm type shm (rw)
	tmpfs on /dev/shm type tmpfs (rw)

Yet, running "x11perf -shmput10" gives me:

X Error of failed request:  BadValue (integer parameter out of range for
operation)
  Major opcode of failed request:  146 (MIT-SHM)
  Minor opcode of failed request:  3 (X_ShmPutImage)
  Value in failed request:  0x1600001
  Serial number of failed request:  35107
  Current serial number in output stream:  35111

I'd like to check to make sure that shm is actually accessible
to my programs.  Is there any easy way to do this?

I have already checked the values of:

	/proc/sys/kernel/shmall = 2000000
	/proc/sys/kernel/shmmax = 4096
	/proc/sys/kernel/shmmni = 35000000

Thanks,
	Miles
