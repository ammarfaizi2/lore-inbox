Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbWBYLIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbWBYLIr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 06:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWBYLIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 06:08:47 -0500
Received: from mx1.suse.de ([195.135.220.2]:14984 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030207AbWBYLIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 06:08:47 -0500
Date: Sat, 25 Feb 2006 12:08:44 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: cramfs mounts provide corrupted content since 2.6.15
Message-ID: <20060225110844.GA18221@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Any ideas why a cramfs mount provides empty files since at least 2.6.15?
It worked ok in 2.6.13 at least. Bug is still present in Linus tree.

These files (from the current openSuSE beta) needed updating. But the results are random.
Right now, after the 3th try, most files are correct, Hostname.so is still zero...

building file list ... done
etc/nsswitch.conf
usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/Data/Dumper/Dumper.so
usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/Fcntl/Fcntl.so
usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/IO/IO.so
usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/POSIX/POSIX.so
usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/Sys/Hostname/Hostname.so
usr/lib/perl5/vendor_perl/5.8.8/ppc-linux-thread-multi-64int/auto/Compress/Zlib/Zlib.so
usr/lib/perl5/vendor_perl/5.8.8/ppc-linux-thread-multi-64int/auto/Locale/gettext/gettext.so
var/spool/locks -> ../lock


lrwxrwxrwx  1 root root 7 1970-01-01 01:00 /mnt/var/spool/locks -> ../lock
lrwxrwxrwx  1 root root 7 2006-02-25 11:55 inst-sys/var/spool/locks -> ../lock
-rw-r--r--  1 root root 1220 1970-01-01 01:00 /mnt/etc/nsswitch.conf
-rw-r--r--  1 root root 1220 1970-01-01 01:00 inst-sys/etc/nsswitch.conf
-r-xr-xr-x  1 root root 36236 1970-01-01 01:00 /mnt/usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/Data/Dumper/Dumper.so
-r-xr-xr-x  1 root root 36236 1970-01-01 01:00 inst-sys/usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/Data/Dumper/Dumper.so
-r-xr-xr-x  1 root root 21136 1970-01-01 01:00 /mnt/usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/Fcntl/Fcntl.so
-r-xr-xr-x  1 root root 21136 1970-01-01 01:00 inst-sys/usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/Fcntl/Fcntl.so
-r-xr-xr-x  1 root root 22644 1970-01-01 01:00 /mnt/usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/IO/IO.so
-r-xr-xr-x  1 root root 22644 1970-01-01 01:00 inst-sys/usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/IO/IO.so
-r-xr-xr-x  1 root root 140852 1970-01-01 01:00 /mnt/usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/POSIX/POSIX.so
-r-xr-xr-x  1 root root 140852 1970-01-01 01:00 inst-sys/usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/POSIX/POSIX.so
-r--r--r--  1 root root     0 1970-01-01 01:00 /mnt/usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/Sys/Hostname/Hostname.so
-r-xr-xr-x  1 root root 11384 1970-01-01 01:00 inst-sys/usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/Sys/Hostname/Hostname.so
-r-xr-xr-x  1 root root 69844 1970-01-01 01:00 /mnt/usr/lib/perl5/vendor_perl/5.8.8/ppc-linux-thread-multi-64int/auto/Compress/Zlib/Zlib.so
-r-xr-xr-x  1 root root 69844 1970-01-01 01:00 inst-sys/usr/lib/perl5/vendor_perl/5.8.8/ppc-linux-thread-multi-64int/auto/Compress/Zlib/Zlib.so
-r-xr-xr-x  1 root root 24004 1970-01-01 01:00 /mnt/usr/lib/perl5/vendor_perl/5.8.8/ppc-linux-thread-multi-64int/auto/Locale/gettext/gettext.so
-r-xr-xr-x  1 root root 24004 1970-01-01 01:00 inst-sys/usr/lib/perl5/vendor_perl/5.8.8/ppc-linux-thread-multi-64int/auto/Locale/gettext/gettext.so


Oh, and doing the md5sum thing shows even more errors.

olaf@ibook:/install/sles10/CD1/boot/ppc/inst-sys> sudo env -i md5sum -c /dev/shm/log  | grep -wv OK$
olaf@ibook:/install/sles10/CD1/boot/ppc/inst-sys> cd /mnt/
olaf@ibook:/mnt> sudo env -i md5sum -c /dev/shm/log  | grep -wv OK$
./etc/mtab: FAILED
./usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/Data/Dumper/Dumper.bs: FAILED
./usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/Fcntl/Fcntl.bs: FAILED
./usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/IO/IO.bs: FAILED
./usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/POSIX/POSIX.bs: FAILED
./usr/lib/perl5/5.8.8/ppc-linux-thread-multi-64int/auto/Sys/Hostname/Hostname.so: FAILED
./usr/lib/perl5/vendor_perl/5.8.8/ppc-linux-thread-multi-64int/auto/Compress/Zlib/Zlib.bs: FAILED
./usr/lib/perl5/vendor_perl/5.8.8/ppc-linux-thread-multi-64int/auto/Locale/gettext/gettext.bs: FAILED
md5sum: ./var/log/faillog: Is a directory
md5sum: ./var/log/lastlog: Is a directory
md5sum: ./var/log/mail: Is a directory
md5sum: ./var/log/messages: Is a directory
md5sum: ./var/log/news/news.crit: No such file or directory
md5sum: ./var/log/news/news.err: No such file or directory
md5sum: ./var/log/news/news.notice: No such file or directory
md5sum: ./var/log/sendmail.st: Is a directory
md5sum: ./var/log/wtmp: Is a directory
md5sum: ./var/log/xdm.errors: Is a directory
md5sum: WARNING: 10 of 6867 listed files could not be read
md5sum: WARNING: 8 of 6857 computed checksums did NOT match
./var/log/faillog: FAILED open or read
./var/log/lastlog: FAILED open or read
./var/log/mail: FAILED open or read
./var/log/messages: FAILED open or read
./var/log/news/news.crit: FAILED open or read
./var/log/news/news.err: FAILED open or read
./var/log/news/news.notice: FAILED open or read
./var/log/sendmail.st: FAILED open or read
./var/log/wtmp: FAILED open or read
./var/log/xdm.errors: FAILED open or read

Looking at the loopmount with a 2.6.13 kernel:

nectarine:~/inst-sys.orig # l ./var/log/lastlog
-rw-r--r--  1 root tty 0 Jan  1  1970 ./var/log/lastlog

olaf@ibook:/mnt> l ./var/log/lastlog
lrwxrwxrwx  1 root root 7 1970-01-01 01:00 ./var/log/lastlog -> ../lock/

