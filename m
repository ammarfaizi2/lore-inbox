Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267876AbUIJVJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267876AbUIJVJh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 17:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267882AbUIJVJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 17:09:37 -0400
Received: from pimout6-ext.prodigy.net ([207.115.63.78]:58592 "EHLO
	pimout6-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267876AbUIJVHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 17:07:53 -0400
Message-ID: <414217AC.8010807@ameritech.net>
Date: Fri, 10 Sep 2004 16:07:56 -0500
From: watermodem <aquamodem@ameritech.net>
Reply-To: aquamodem@ameritech.net
Organization: not at all
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: tigran@veritas.com
Subject: Re: Latest microcode data from Intel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A bit of a bug somewhere here...   If it is my mistake by having
the linux link pointing to ...
   linux -> linux-2.6.8.1/
sorry...  (I don't remember which libs were proper)
If it is not that... then the package has a bug.

Error:

rpm -U /usr/src/RPM/RPMS/i586/microcode_ctl-1.09-1.i586.rpm
error: %preun(microcode_ctl-1.06-6mdk) scriptlet failed, exit status 1


Leading up to this was:
rpmbuild -ta microcode_ctl-1.09.tar.gz
Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.76578
+ umask 022
+ cd /usr/src/RPM/BUILD
+ cd /usr/src/RPM/BUILD
+ rm -rf microcode_ctl-1.09
+ /usr/bin/gzip -dc /home/watermod/Documents/microcode_ctl-1.09.tar.gz
+ tar -xf -
+ STATUS=0
+ '[' 0 -ne 0 ']'
+ cd microcode_ctl-1.09
+ exit 0
Executing(%build): /bin/sh -e /var/tmp/rpm-tmp.76578
+ umask 022
+ cd /usr/src/RPM/BUILD
+ cd microcode_ctl-1.09
+ make
gcc -g -Wall -O2 -I /usr/src/linux/include -o microcode_ctl microcode_ctl.c
In file included from /usr/src/linux/include/asm/processor.h:18,
                  from microcode_ctl.c:30:
/usr/src/linux/include/asm/system.h: In function `__set_64bit_var':
/usr/src/linux/include/asm/system.h:193: warning: dereferencing 
type-punned pointer will break strict-aliasing rules
/usr/src/linux/include/asm/system.h:193: warning: dereferencing 
type-punned pointer will break strict-aliasing rules
In file included from microcode_ctl.c:30:
/usr/src/linux/include/asm/processor.h: In function `load_esp0':
/usr/src/linux/include/asm/processor.h:453: warning: implicit 
declaration of function `unlikely'
echo "/etc/init.d/microcode_ctl" > microcode-filelist
+ exit 0
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.91789
+ umask 022
+ cd /usr/src/RPM/BUILD
+ cd microcode_ctl-1.09
+ '[' /var/tmp/microcode_ctl-1.09-root '!=' / ']'
+ '[' -d /var/tmp/microcode_ctl-1.09-root ']'
+ make DESTDIR=/var/tmp/microcode_ctl-1.09-root PREFIX=/usr install clean
install -d      /var/tmp/microcode_ctl-1.09-root/usr/sbin 
/var/tmp/microcode_ctl-1.09-root/etc \
                 /var/tmp/microcode_ctl-1.09-root/usr/man/man8 
/var/tmp/microcode_ctl-1.09-root/etc/init.d \
                 /var/tmp/microcode_ctl-1.09-root
install -s -m 755 microcode_ctl /var/tmp/microcode_ctl-1.09-root/usr/sbin
install -m 644 intel-ia32microcode-02Sep2004.txt 
/var/tmp/microcode_ctl-1.09-root/etc/microcode.dat
install -m 644 microcode_ctl.8 /var/tmp/microcode_ctl-1.09-root/usr/man/man8
gzip -9f /var/tmp/microcode_ctl-1.09-root/usr/man/man8/microcode_ctl.8
install -m 755 microcode_ctl.start 
/var/tmp/microcode_ctl-1.09-root/etc/init.d/microcode_ctl
echo "MAKE: Skipping chkconfig operation (rpm build?)"
MAKE: Skipping chkconfig operation (rpm build?)
rm -f microcode_ctl
+ /usr/lib/rpm/brp-mandrake
Cleaning files...done
Compressing files...done
Stripping files...done
Relativisation of symlinks...done
Clean perl...done
Building libraries symlinks...done
Gprintifying init scripts...done
Processing files: microcode_ctl-1.09-1
Finding  Provides: /usr/lib/rpm/filter.sh ' ' /usr/lib/rpm/find-provides
Using BuildRoot: /var/tmp/microcode_ctl-1.09-root to search libs
Finding  Requires: /usr/lib/rpm/filter.sh ' ' /usr/lib/rpm/find-requires 
/var/tmp/microcode_ctl-1.09-root i586
Requires(interp): /bin/sh /bin/sh
Requires(rpmlib): rpmlib(PayloadFilesHavePrefix) <= 4.0-1 
rpmlib(CompressedFileNames) <= 3.0.4-1
Requires(post): /bin/sh
Requires(preun): /bin/sh
Requires: bash libc.so.6 libc.so.6(GLIBC_2.0) libc.so.6(GLIBC_2.1)
Checking for unpackaged file(s): /usr/lib/rpm/check-files 
/var/tmp/microcode_ctl-1.09-root
Wrote: /usr/src/RPM/SRPMS/microcode_ctl-1.09-1.src.rpm
Wrote: /usr/src/RPM/RPMS/i586/microcode_ctl-1.09-1.i586.rpm
Executing(%clean): /bin/sh -e /var/tmp/rpm-tmp.99129
+ umask 022
+ cd /usr/src/RPM/BUILD
+ cd microcode_ctl-1.09
+ '[' /var/tmp/microcode_ctl-1.09-root '!=' / ']'
+ '[' -d /var/tmp/microcode_ctl-1.09-root ']'
+ rm -r /var/tmp/microcode_ctl-1.09-root
+ exit 0
