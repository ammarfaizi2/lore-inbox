Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285161AbSBGHYS>; Thu, 7 Feb 2002 02:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285226AbSBGHYI>; Thu, 7 Feb 2002 02:24:08 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:11399 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S285161AbSBGHX7>; Thu, 7 Feb 2002 02:23:59 -0500
Date: Thu, 7 Feb 2002 08:23:48 +0100
From: Alex Riesen <riesen@synopsys.COM>
To: reiserfs-dev@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.4-pre1: zero-filled files resiserfs
Message-ID: <20020207082348.A26413@riesen-pc.gr05.synopsys.com>
Reply-To: riesen@synopsys.COM
Mail-Followup-To: reiserfs-dev@namesys.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got the zero-filled files after reboot. I've tried
to compile two kernels (one with make -j2 and
the other one just with make) simultaneously having
3 running 'find . -type f print0 | xargs -0 cat >/dev/null'.

After reboot i've got .config of the one of the kernels
filled with zeroes, also .bash_history and some others
(all of them reside on a reserfs volume, and my home, btw).
The copies of the bzImage's and modules are ok (they were
to ext2 volumes).
I suppose the files were open for writing at some point
of that session. I'm sure they were closed to the moment
of system shutdown (i've killall5 -TERM ... sequence in
the shutdown scripts).

There were no crashes or suspicious messages on the console.
Nothing special in logs, and sorry, reiserfs self-debugging
wasn't enabled.

-alex

