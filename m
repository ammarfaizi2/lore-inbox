Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWAWHF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWAWHF3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 02:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWAWHF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 02:05:28 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:12732 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S964821AbWAWHF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 02:05:28 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Mon, 23 Jan 2006 08:04:32 +0100
MIME-Version: 1.0
Content-type: Multipart/Mixed; boundary=Message-Boundary-20976
Subject: Question on: 2.4.29 -> 2.4.32
Message-ID: <43D48E10.18012.BDE14@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.30 public beta 1)
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.98.0+V=3.98+U=2.07.112+R=03 October 2005+T=114499@20060123.070227Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Message-Boundary-20976
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body

(Note: Please CC: any replies to me)
Hi!

when viewing the differences between kernel 2.4.29 to 2.4.32,I wondered whether 
these lines (with nothing in between) make any sense:

      write_lock_irqsave(&bfusb->lock, flags);
      write_unlock_irqrestore(&bfusb->lock, flags);


      /* Synchronize with completion handlers */
      write_lock_irqsave(&husb->completion_lock, flags);
      write_unlock_irqrestore(&husb->completion_lock, flags);

See attached diffs for more detail.

Regards,
Ulrich


--Message-Boundary-20976
Content-type: Application/Octet-stream; name="2931mystery1.diff"; type=Unknown
Content-disposition: attachment; filename="2931mystery1.diff"
Content-transfer-encoding: BASE64

LS0tIGRyaXZlcnMvYmx1ZXRvb3RoL2JmdXNiLmMgICAyMiBKYW4gMjAwNSAyMDo1NDozOCAt
MDAwMCAgICAgIDEuMS4xLjIKKysrIGRyaXZlcnMvYmx1ZXRvb3RoL2JmdXNiLmMgICAxOSBK
YW4gMjAwNiAxOToxOToxNSAtMDAwMCAgICAgIDEuMS4xLjMKQEAgLTQ3MCwxMiArNDcwLDEx
IEBACiAgICAgICAgICAgICAgICByZXR1cm4gMDsKCiAgICAgICAgd3JpdGVfbG9ja19pcnFz
YXZlKCZiZnVzYi0+bG9jaywgZmxhZ3MpOworICAgICAgIHdyaXRlX3VubG9ja19pcnFyZXN0
b3JlKCZiZnVzYi0+bG9jaywgZmxhZ3MpOwoKICAgICAgICBiZnVzYl91bmxpbmtfdXJicyhi
ZnVzYik7CiAgICAgICAgYmZ1c2JfZmx1c2goaGRldik7CgotICAgICAgIHdyaXRlX3VubG9j
a19pcnFyZXN0b3JlKCZiZnVzYi0+bG9jaywgZmxhZ3MpOwotCiAgICAgICAgTU9EX0RFQ19V
U0VfQ09VTlQ7CgogICAgICAgIHJldHVybiAwOwoKLS0tIGRyaXZlcnMvYmx1ZXRvb3RoL2hj
aV91c2IuYyAyMiBKYW4gMjAwNSAyMDo1NDozOCAtMDAwMCAgICAgIDEuMS4xLjgKKysrIGRy
aXZlcnMvYmx1ZXRvb3RoL2hjaV91c2IuYyAxOSBKYW4gMjAwNiAxOToxOToxNSAtMDAwMCAg
ICAgIDEuMS4xLjkKQEAgLTM5OCwxMyArMzk4LDEzIEBACgogICAgICAgIEJUX0RCRygiJXMi
LCBoZGV2LT5uYW1lKTsKCisgICAgICAgLyogU3luY2hyb25pemUgd2l0aCBjb21wbGV0aW9u
IGhhbmRsZXJzICovCiAgICAgICAgd3JpdGVfbG9ja19pcnFzYXZlKCZodXNiLT5jb21wbGV0
aW9uX2xvY2ssIGZsYWdzKTsKLQorICAgICAgIHdyaXRlX3VubG9ja19pcnFyZXN0b3JlKCZo
dXNiLT5jb21wbGV0aW9uX2xvY2ssIGZsYWdzKTsKKwogICAgICAgIGhjaV91c2JfdW5saW5r
X3VyYnMoaHVzYik7CiAgICAgICAgaGNpX3VzYl9mbHVzaChoZGV2KTsKCi0gICAgICAgd3Jp
dGVfdW5sb2NrX2lycXJlc3RvcmUoJmh1c2ItPmNvbXBsZXRpb25fbG9jaywgZmxhZ3MpOwot
CiAgICAgICAgTU9EX0RFQ19VU0VfQ09VTlQ7CiAgICAgICAgcmV0dXJuIDA7CiB9Cg==

--Message-Boundary-20976--
