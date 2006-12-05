Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755972AbWLEXdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755972AbWLEXdA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 18:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758140AbWLEXc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 18:32:59 -0500
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:21955 "EHLO
	outbound3-fra-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755972AbWLEXc5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 18:32:57 -0500
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [LinuxBIOS] [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early
 usb debug port support.
Date: Tue, 5 Dec 2006 15:29:32 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA490728A@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [LinuxBIOS] [linux-usb-devel] [RFC][PATCH 0/2] x86_64
 Early usb debug port support.
Thread-Index: AccYw/zOagCxxqbcSVaHCEN1woRl+AAAL8gQ
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com, "David Brownell" <david-b@pacbell.net>
cc: "Peter Stuge" <stuge-linuxbios@cdy.org>,
       linux-usb-devel@lists.sourceforge.net,
       "Stefan Reinauer" <stepan@coresystems.de>, "Greg KH" <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, linuxbios@linuxbios.org,
       "Andi Kleen" <ak@suse.de>
X-OriginalArrivalTime: 05 Dec 2006 23:29:34.0169 (UTC)
 FILETIME=[38AACC90:01C718C5]
X-WSS-ID: 6968DF571WC2183802-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: linuxbios-bounces@linuxbios.org
[mailto:linuxbios-bounces@linuxbios.org] On Behalf Of
ebiederm@xmission.com
Sent: Tuesday, December 05, 2006 3:01 AM

>+static int ehci_wait_for_port(int port)
>+{
>+	unsigned status;
>+	int ret, reps;
>+	for (reps = 0; reps >= 0; reps++) {
>+		status = readl(&ehci_regs->status);
>+		if (status & STS_PCD) {
>+			ret = ehci_reset_port(port);
>+			if (ret == 0)
>+				return 0;
>+		}
>+	}
>+	return -ENOTCONN;
>+}
>+

What do you mean by
+	for (reps = 0; reps >= 0; reps++) {
?

YH



