Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130399AbRCPHrp>; Fri, 16 Mar 2001 02:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130406AbRCPHrg>; Fri, 16 Mar 2001 02:47:36 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:60943 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S130399AbRCPHrX>; Fri, 16 Mar 2001 02:47:23 -0500
Message-ID: <3AB1D312.E6965E0A@t-online.de>
Date: Fri, 16 Mar 2001 09:47:14 +0100
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk
CC: linux-kernel@vger.kernel.org
Subject: Patch(2.4.2): serial.c timedia oneliner (Resend)
Content-Type: multipart/mixed;
 boundary="------------E09AC4F5EA08EEA37F420F22"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E09AC4F5EA08EEA37F420F22
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,
please apply this oneliner to fix the Timedia/Sunix series PCI cards.

Regards, Gunther


P.S.
I'm sending this since 3 months to the maintainer (tytso@mit.edu)
and even submitted to serial.sourceforge.net but never got a reaction.
Anybody knows if Ted is still active?


--- linux/drivers/char/serial.c-242-orig        Fri Mar 16 09:32:22 2001
+++ linux/drivers/char/serial.c Fri Mar 16 09:34:32 2001
@@ -4175,7 +4175,7 @@
        for (i=0; timedia_data[i].num; i++) {
                ids = timedia_data[i].ids;
                for (j=0; ids[j]; j++) {
-                       if (pci_get_subvendor(dev) == ids[j]) {
+                       if (pci_get_subdevice(dev) == ids[j]) {
                                board->num_ports = timedia_data[i].num;
                                return 0;
                        }
--------------E09AC4F5EA08EEA37F420F22
Content-Type: application/octet-stream;
 name="gmdiff-lx242-serialc-timedia-oneliner"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="gmdiff-lx242-serialc-timedia-oneliner"

LS0tIGxpbnV4L2RyaXZlcnMvY2hhci9zZXJpYWwuYy0yNDItb3JpZwlGcmkgTWFyIDE2IDA5
OjMyOjIyIDIwMDEKKysrIGxpbnV4L2RyaXZlcnMvY2hhci9zZXJpYWwuYwlGcmkgTWFyIDE2
IDA5OjM0OjMyIDIwMDEKQEAgLTQxNzUsNyArNDE3NSw3IEBACiAJZm9yIChpPTA7IHRpbWVk
aWFfZGF0YVtpXS5udW07IGkrKykgewogCQlpZHMgPSB0aW1lZGlhX2RhdGFbaV0uaWRzOwog
CQlmb3IgKGo9MDsgaWRzW2pdOyBqKyspIHsKLQkJCWlmIChwY2lfZ2V0X3N1YnZlbmRvcihk
ZXYpID09IGlkc1tqXSkgeworCQkJaWYgKHBjaV9nZXRfc3ViZGV2aWNlKGRldikgPT0gaWRz
W2pdKSB7CiAJCQkJYm9hcmQtPm51bV9wb3J0cyA9IHRpbWVkaWFfZGF0YVtpXS5udW07CiAJ
CQkJcmV0dXJuIDA7CiAJCQl9Cg==
--------------E09AC4F5EA08EEA37F420F22--

