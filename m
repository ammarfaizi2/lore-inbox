Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266351AbUHVVl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266351AbUHVVl0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 17:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266469AbUHVVjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 17:39:36 -0400
Received: from qfep05.superonline.com ([212.252.122.162]:62640 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S266319AbUHVVil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 17:38:41 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Albert Cahalan'" <albert@users.sf.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Cursed Checksums
Date: Mon, 23 Aug 2004 00:38:30 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <1093200924.5759.3088.camel@cube>
Thread-Index: AcSIj3Pv+m1w+YlTTOau+WTjWLCOdwACJfcg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-Id: <S266319AbUHVVil/20040822213841Z+233@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In normal conditions, when NAT translates an IP header, it should do correct
checksumming. However; when the source IP address of a packet is
manipulated, Iptables still seems to use the "original" IP address and
calculate the checksum accordingly. This way even if I use 3 three boxes;

Original Packet --> NAT 1 --> NAT 2 --> NAT3 --> Still incorrect checksum

The wrong checksum is carried over and over the line. It is really a strange
issue and I could not find a reason why still I get the incorrect checksum
even after the IP header is translated three times...

As I said, the original packet must be corrected before it is transmitted to
another place and I think it is just two or three lines of code in the
kernel, but the question is "where"...

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Albert Cahalan
Sent: Sunday, August 22, 2004 8:55 PM
To: linux-kernel mailing list
Subject: RE: Cursed Checksums

I'm surprised to find that there doesn't seem to
be an ebtables mangle table. That'd be the place
to match on a u32, then either change that or just
mark the packet for checksuming.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



