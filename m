Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312792AbSDBPmf>; Tue, 2 Apr 2002 10:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312802AbSDBPmQ>; Tue, 2 Apr 2002 10:42:16 -0500
Received: from web14912.mail.yahoo.com ([216.136.225.248]:14342 "HELO
	web14912.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312792AbSDBPmF>; Tue, 2 Apr 2002 10:42:05 -0500
Message-ID: <20020402154200.30415.qmail@web14912.mail.yahoo.com>
Date: Tue, 2 Apr 2002 10:42:00 -0500 (EST)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: Get major number in Makefile
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, smart gurus, I have a question while writing a
Makefile file to install my device driver. In my
device driver I dynamically allocate the major number
of my device. In my Makefile I want to build a device
node for my device under the /dev directory.

   mknod /dev/mydevice c $major 0;

So I need to know the major number of my deivce in the
Makefile. I've read the Linux 'Device Driver'. There
is some information about this. I use the following
command to get the major number in my Makefile.

major=`awk "\\$2==\"$mymodule\" {printf \\$1}"
/proc/devices`

But when I use the 'make install' command to install
my driver, the following error returned.

major=`awk "\\==\"$ymodule\" {printf \\}"
/proc/devices`
awk: 0: unexpected character '\'
awk: line 1: syntax error at or near ==
make: *** [install] Error 2

What is wrong with my command? Can anyone tell me how
to get the major number in Makefile.

Thank you very much.


______________________________________________________________________ 
Find, Connect, Date! http://personals.yahoo.ca
