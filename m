Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272667AbTG1E6y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 00:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272671AbTG1E6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 00:58:54 -0400
Received: from franka.aracnet.com ([216.99.193.44]:21473 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S272667AbTG1E6x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 00:58:53 -0400
Date: Sun, 27 Jul 2003 22:13:54 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 982] New: cu -l /dev/ttyS0 got a signal hangup in 2.5 kernel 
Message-ID: <3606320000.1059369234@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=982

           Summary: cu -l /dev/ttyS0 got a signal hangup in 2.5 kernel
    Kernel Version: 2.5.75
            Status: NEW
          Severity: normal
             Owner: rmk@arm.linux.org.uk
         Submitter: hien1@us.ibm.com
                CC: sglass@us.ibm.com


Distribution: SuSE SLES8 
Hardware Environment:NetVista 6579-A4U Pentium III - 866 MHz 256MB RAM 
Software Environment:2.5.75 kernel 
Problem Description: cu session fails to log into the other machine which is connected with a 
null modem serial cable between serial ports. 
It works fine in 2.4.19 4GB kernel 
 
Steps to reproduce: 
  1. connecting two systems with a null modem serial cable between serial ports. 
  2. On one machine, do : cu -l /dev/ttyS0 
      On other system, have /sbin/agetty -L 9600 ttyS0 vt100  running. 
      and ttyS0 has been defined in /etc/securetty 
  3. cu session connected and showed you the login prompt. 
  4. Got a hangup signal and disconnected after typing "root" or any user ID. 
      It supposes to prompt you "password:" to let you type the password of the other machine 
      to login to that system.

