Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVAERVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVAERVK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 12:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbVAERVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 12:21:10 -0500
Received: from hazard.jcu.cz ([160.217.1.6]:9088 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id S261943AbVAERUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 12:20:34 -0500
Date: Wed, 5 Jan 2005 18:20:30 +0100
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: bcollins@debian.org
Subject: [PROBLEM] 2.6.10: sbp2 vs usb-storage have 16-byte offset
Message-ID: <20050105172030.GA4390@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hallo l-k,

I'm using external disc box from Spire with dual USB/IEEE1394 interface
(GigaPod CF103-NEB, http://www.spirecoolers.com/acc.asp?ProdID=95).

Although I can use my IDE disc (WD600JB) OK via USB, I cannot deal with
this disc via ieee1394. I tried to debug this situation and I've
found, that via ieee1394 are data from disc moved with 16B offset
from data via USB (I can mount this disk via IDE interface, then I
suppose, that USB deal with this disc in right way, or in another words:
in the same way as IDE). I've got different size of device, too
(ieee1394 has wrong size, difference is ieee1394=USB-1 block).

I'm sending in attachment 2 files: isdb2.sec2 and usdb2.sec2

isdb2.sec2 is got via ieee1394 (and sbp2), usdb2.sec2 is via USB (and
usb-storage). Files are created throught this command:

dd if=/dev/sdb2 of=[i,u]sdb2.sec2 bs=512 count=1 skip=2

Hope that help to debug...

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080

--opJtzjQTFsWo+cga
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="isdb2.sec2"
Content-Transfer-Encoding: base64

AAAAAAAAAACgmkoAABiVAGZ0BwD/0ysAfLVJAAAAAAACAAAAAgAAAACAAAAAgAAA4D8AAO8L
20FJG9tBAgAZAFPvAQABAAAAfQTbQQBO7QAAAAAAAQAAAAAAAAALAAAAgAAAAAQAAAACAAAA
AQAAAKs9inV9hUL0uy93S01wE64AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAFSW4j1J9kk6jKGVRZb1aNkCAQAAAAAAAAAA
AAD0EuNACgIAAAsCAAAMAgAADQIAAA4CAAAPAgAAEAIAABECAAASAgAAEwIAABQCAAAVAgAA
FgIAABcGAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=

--opJtzjQTFsWo+cga
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="usdb2.sec2"
Content-Transfer-Encoding: base64

oJpKAAAYlQBmdAcA/9MrAHy1SQAAAAAAAgAAAAIAAAAAgAAAAIAAAOA/AADvC9tB7wvbQQIA
GQBT7wEAAQAAAH0E20EATu0AAAAAAAEAAAAAAAAACwAAAIAAAAAEAAAABgAAAAEAAACrPYp1
fYVC9Lsvd0tNcBOuAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAIAAAAAAAAAAAAAABUluI9SfZJOoyhlUWW9WjZAgEAAAAAAAAAAAAA9BLjQAoC
AAALAgAADAIAAA0CAAAOAgAADwIAABACAAARAgAAEgIAABMCAAAUAgAAFQIAABYCAAAXBgAA
AAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=

--opJtzjQTFsWo+cga--
