Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbUCWQGd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 11:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbUCWQGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 11:06:33 -0500
Received: from matrix.roma2.infn.it ([141.108.255.2]:4272 "EHLO
	matrix.roma2.infn.it") by vger.kernel.org with ESMTP
	id S262635AbUCWQGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 11:06:31 -0500
From: "Emiliano 'AlberT' Gabrielli" <AlberT@agilemovement.it>
Reply-To: AlberT@agilemovement.it
Organization: SuperAlberT.it
To: linux-kernel@vger.kernel.org
Subject: Hidden PIDs in /proc
Date: Tue, 23 Mar 2004 17:08:15 +0100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403231708.15812.AlberT@agilemovement.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

   I discovered some "hidden" pid dirs in /proc :

root@emc2:# ls -lha /proc/ | grep 4673
root@emc2:# ls -lha /proc/4673/
totale 0
dr-xr-xr-x    3 albert   albert          0 2004-03-23 17:02 .
dr-xr-xr-x  108 root     root            0 2004-03-23 16:10 ..
dr-xr-xr-x    2 albert   albert          0 2004-03-23 17:03 attr
-r--------    1 albert   albert          0 2004-03-23 17:03 auxv
-r--r--r--    1 albert   albert          0 2004-03-23 17:03 cmdline
lrwxrwxrwx    1 albert   albert          0 2004-03-23 17:02 cwd 
-> /home/albert
-r--------    1 albert   albert          0 2004-03-23 17:03 environ
lrwxrwxrwx    1 albert   albert          0 2004-03-23 17:02 exe 
-> /usr/lib/mozilla-firefox/firefox-bin
dr-x------    2 albert   albert          0 2004-03-23 17:03 fd
-r--r--r--    1 albert   albert          0 2004-03-23 17:03 maps
-rw-------    1 albert   albert          0 2004-03-23 17:03 mem
-r--r--r--    1 albert   albert          0 2004-03-23 17:03 mounts
lrwxrwxrwx    1 albert   albert          0 2004-03-23 17:03 root -> /
-r--r--r--    1 albert   albert          0 2004-03-23 17:03 stat
-r--r--r--    1 albert   albert          0 2004-03-23 17:03 statm
-r--r--r--    1 albert   albert          0 2004-03-23 17:03 status
dr-xr-xr-x    3 albert   albert          0 2004-03-23 17:03 task
-r--r--r--    1 albert   albert          0 2004-03-23 17:03 wchan


Obviously this is a persistent process, not a process living only for the 
second test lifetime.

After 2 days of headhake searching for possible rootkits, reinstalling all the 
basic system, libs and so on (from a clean live-CD boot) ...
I noticed that these process seem all to use pthreads ... so, the question is:

is my problem related/solved by the initramfs-search-for-init-zombie-fix.patch
in the -mm1 tree ??

thank you in advance

-- 
                       Emiliano `AlberT` Gabrielli  

E-Mail: AlberT@SuperAlberT.it  -  Web:    http://SuperAlberT.it
Membro dell'Italian Agile Movement - AlberT@agilemovement.it
