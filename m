Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285168AbRLXRB6>; Mon, 24 Dec 2001 12:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285173AbRLXRBs>; Mon, 24 Dec 2001 12:01:48 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:40204 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S285168AbRLXRBo>;
	Mon, 24 Dec 2001 12:01:44 -0500
Date: Mon, 24 Dec 2001 18:01:42 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Data sitting and remaining in Send-Q
Message-ID: <20011224180142.E2461@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've got some problem with a freshly installed Debian sid system.
It's running with 2.4.16, 2.4.17-rc2 and 2.4.17 (the problem
appears on all these kernels) and something seems to break ssh.

When ssh'ing to this box (only this box, regardless which client)
the connection breaks if I request more than some dozends of bytes
at a time (so it will break at 'ls -l' with more than 10 files,
'cat /etc/passwd' will break, calling 'vi' will also break, because
it re-displays all the screen.

When strace'ing ssh client and server, I can see that both of them
are in a select() loop. On the broken server, netstat shows some
(kilo)bytes of data remaining in the Send-Q. However, this data
is actually *never* send over the wire letting the connection die.

Can anybody give me some hint on how to solve this?

Marry Chrismas, JBG

-- 
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/
