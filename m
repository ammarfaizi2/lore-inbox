Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267885AbTAHVkF>; Wed, 8 Jan 2003 16:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267894AbTAHVkF>; Wed, 8 Jan 2003 16:40:05 -0500
Received: from hancock.siteprotect.com ([64.41.120.29]:22668 "EHLO
	hancock.siteprotect.com") by vger.kernel.org with ESMTP
	id <S267885AbTAHVkC>; Wed, 8 Jan 2003 16:40:02 -0500
Date: Wed, 8 Jan 2003 15:47:41 -0600
From: Dee <dfisher@uptimedevices.com>
To: linux-kernel@vger.kernel.org
Subject: Etherleak
Message-Id: <20030108154741.21095993.dfisher@uptimedevices.com>
Organization: Uptime Devices
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Forward:


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

                                @stake, Inc.
                              www.atstake.com

                             Security Advisory

Advisory Name: Etherleak: Ethernet frame padding information leakage
 Release Date: 01/06/2003
  Application: Ethernet device driver software
     Platform: Multiple
     Severity: Information disclosure
      Authors: Ofir Arkin <ofir@sys-security.com>
               Josh Anderson
Vendor Status: Multiple vendors alerted via CERT Coordination Center
CVE Candidate: CAN-2003-0001
    Reference: www.atstake.com/research/advisories/2003/a010603-1.txt


Overview:

Multiple platform ethernet Network Interface Card (NIC) device
drivers incorrectly handle frame padding, allowing an attacker to
view slices of previously transmitted packets or portions of kernel
memory. This vulnerability is the result of incorrect implementations
of RFC requirements and poor programming practices, the combination
of which results in several variations of this information leakage
vulnerability.

The simplest attack using this vulnerability would be to send ICMP
echo messages to a machine with a vulnerable ethernet driver.
Portions of kernel memory will be returned to the attacker in the
padding of the reply messages.  During testing we have found that
the portions returned are typically snippets of network traffic
that the vulnerable machine is handling.  This attack can allow
an attacker to see portions of the traffic that a router or firewall
is handling on network segments the attacker has no direct access
too.  It is important to note that the attacker must be on the
same ethernet network as the vulnerable machine to receive the
ethernet frames.

      
Details:

@stake has prepared a detailed report on this issue. The
vulnerability is explored in its various manifestations through
code examples and packet captures.

Report available at:

www.atstake.com/research/advisories/2003/atstake_etherleak_report.pdf


Vendor Response:

Multiple platform and hardware vendors were contacted via the CERT
Coordination Center on  06/25/02.  Detailed vendor response
information is available in CERT vulnerability note VU#412115.

http://www.kb.cert.org/vuls/id/412115

Recommendation:

Contact the vendor of your ethernet device drivers or your hardware
vendor for a patch.

End to end encryption technologies such as SSL, IPSEC, and SSH
should be used when transmitting sensitive data over a network. Using
encryption will help protect against this issue partly. It is not a
complete solution because the kernel data leaked in the ethernet
frame padding is not always the IP packet data portion of a
previous frame.  Sometimes it is unencrypted IP header information or
other kernel memory.


Common Vulnerabilities and Exposures (CVE) Information:

The Common Vulnerabilities and Exposures (CVE) project has assigned
the following names to these issues.  These are candidates for
inclusion in the CVE list (http://cve.mitre.org), which standardizes
names for security problems.

  CAN-2003-0001 Ethernet frame padding information leakage


@stake Vulnerability Reporting Policy:
http://www.atstake.com/research/policy/

@stake Advisory Archive: http://www.atstake.com/research/advisories/

PGP Key:
http://www.atstake.com/research/pgp_key.asc

Copyright 2003 @stake, Inc. All rights reserved.


-----BEGIN PGP SIGNATURE-----
Version: PGP 8.0

iQA/AwUBPhmc+Ee9kNIfAm4yEQKyjACgnvi0ZuRUb94nfcG0zMHPzl6XdZQAn1tG
TXcUNSc0uLgCvhUp0vQAu7+J
=3Dtx
-----END PGP SIGNATURE-----


	Was wondering if anyone had patchs for listed drivers?
