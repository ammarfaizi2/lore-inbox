Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271477AbTGQOvo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 10:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271478AbTGQOvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 10:51:43 -0400
Received: from franka.aracnet.com ([216.99.193.44]:36249 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S271477AbTGQOvk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 10:51:40 -0400
Date: Thu, 17 Jul 2003 08:06:21 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 933] New: FTP NAT doesn't work in 2.6.0-test1 
Message-ID: <16810000.1058454381@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=933

           Summary: FTP NAT doesn't work in 2.6.0-test1
    Kernel Version: 2.6.0-test1
            Status: NEW
          Severity: normal
             Owner: laforge@gnumonks.org
         Submitter: pavelr@coresma.com


Distribution: Red Hat 9
Hardware Environment: 
Software Environment: gcc-3.3
Problem Description:

Both IP masquerading and SNAT do not work with FTP. When I issue dir command,
ftp connection gets stuck. In ethernet sniffer I see a lot of TCP ack packets
going in both directions. Both FTP client and server are Win2k boxes. 

Steps to reproduce:

Setup a NAT box
modprobe ip_nat_ftp
modprobe ip_conntrack_ftp
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE (assuming eth0 is an
external interface)

Try ftp connection.

This setup works fine with RedHat kernel 2.4.20-18.9.

