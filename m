Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132789AbRDIQD6>; Mon, 9 Apr 2001 12:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132786AbRDIQDt>; Mon, 9 Apr 2001 12:03:49 -0400
Received: from staffnet.com ([207.226.80.14]:21775 "EHLO staffnet.com")
	by vger.kernel.org with ESMTP id <S132784AbRDIQDk>;
	Mon, 9 Apr 2001 12:03:40 -0400
Message-ID: <3AD1DD59.C28C401C@staffnet.com>
Date: Mon, 09 Apr 2001 12:03:37 -0400
From: Wade Hampton <whampton@staffnet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: oops script for /usr/src/linux/scripts
Content-Type: multipart/mixed;
 boundary="------------581248121575C430E4BFF6E4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------581248121575C430E4BFF6E4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I made a simple bug_report.sh script to facilitate 
generating a bug report.  It could be included in 
/usr/src/linux/scripts and could be referenced in
/usr/src/linux/BUG-REPORTING.

If anyone is interested, please see attached.

Cheers,
-- 
W. Wade, Hampton  <whampton@staffnet.com>
--------------581248121575C430E4BFF6E4
Content-Type: application/x-sh;
 name="bug_report.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bug_report.sh"

#!/bin/bash
#
# Module:   bug_report.sh
# Purpose:  to build a simple template for a bug report
# Author:   Wade Hampton
# Date:     4/9/2001
# History:  [from RCS]
# $Log: bug_report.sh,v $
# Revision 1.1  2001/04/09 14:59:34  wadeh
# Initial revision
#
#
# Notes:  
# 1)  The contents were stolen from /usr/src/linux/REPORTING-BUGS
#     from the Linux kernel 2.4.3.
# 2)  Output is to stdout.
# 3)  This assumes that the program ver_linux is in /usr/src/linux/scripts
#     and has been properly setup.  If not, change VER_LINUX variable.
#
# Copyright:  GPL
#
#----------------------------------------------------------------------
# CUSTOMIZATION STUFF HERE!
# define how to run the ver_linux script
VER_LINUX="/bin/bash /usr/src/linux/scripts/ver_linux"

# get info on this host
HOSTNAME=`hostname`

# current date
DDATE=`date`
#
# lspci -vvv should be run as root.... 
LSPCI='/sbin/lspci -vvv'
#
#----------------------------------------------------------------------
# START THE OUTPUT

echo "BUG report for $HOSTNAME on $DDATE"
echo "[1.] One line summary of the problem:    "
echo "--"
echo 

echo "[2.] Full description of the problem/report:"
echo "--"
echo 

echo "[3.] Keywords (i.e., modules, networking, kernel):"
echo "--"
echo 

echo "[4.] Kernel version (from /proc/version):"
cat /proc/version
echo 

echo "[5.] Output of Oops.. message (if applicable) with symbolic information "
echo "     resolved (see Documentation/oops-tracing.txt)"
echo "--"
echo 


echo "[6.] A small shell script or example program which triggers the"
echo "     problem (if possible)"
echo "--"
echo 

echo "[7.] Environment"
echo "[7.1.] Software (add the output of the ver_linux script here)"
$VER_LINUX
echo

echo "[7.2.] Processor information (from /proc/cpuinfo):"
cat /proc/cpuinfo
echo

echo "[7.3.] Module information (from /proc/modules):"
cat /proc/modules
echo

echo "[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)"
cat /proc/ioports
echo
cat /proc/iomem
echo

echo "[7.5.] PCI information ('lspci -vvv' as root)"
$LSPCI
echo

echo "[7.6.] SCSI information (from /proc/scsi/scsi)"
cat /proc/scsi/scsi
echo

echo "[7.7.] Other information that might be relevant to the problem"
echo "       (please look in /proc and include all information that you"
echo "       think to be relevant):"
echo

echo "[X.] Other notes, patches, fixes, workarounds:"
echo




--------------581248121575C430E4BFF6E4--

