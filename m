Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbVDYLos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbVDYLos (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 07:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVDYLos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 07:44:48 -0400
Received: from smtp5.infineon.com ([217.10.50.127]:65306 "EHLO
	smtp5.infineon.com") by vger.kernel.org with ESMTP id S262592AbVDYLo1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 07:44:27 -0400
X-SBRS: None
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: Mounting File System .
Date: Mon, 25 Apr 2005 17:13:48 +0530
Message-ID: <D99246B510C34944823191CB90759C8652804C@blrse201.ap.infineon.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Mounting File System .
Thread-Index: AcVJcQhsRqE0tIoyRE+u98Qe1n3FrAAGZauQ
From: <Mansi.Mahur@infineon.com>
To: <dedekind@oktetlabs.ru>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Apr 2005 11:43:50.0405 (UTC) FILETIME=[0C826B50:01C5498C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks fo your response, 
I use NOR flash . I am testing the system using LTP test case . Flash
Image is not prepared by me . I simply mount jffs2 on to a mount point
and test for jffs2 . But the behaviour is seen that if I give mount
point as /tmp and not any other directory I get abnormal behaviour like:

1.following log seen
[root@Linux tmp]$ waiting for chip to be ready timed out in word write
Write error in obliterating obsoleted node at 0x0011c570: -5
Unable to handle kernel NULL pointer dereference at virtual address
00000000
pgd = c3d08000
[00000000] *pgd=c3d4c011, *pte=00000000, *ppte=00000000
Internal error: Oops: 807 [#1].........................................

3.)  mount after this I  get 
root@Linux /]$ mount -t jffs2 /dev/mtdblock0 /tmp
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x002a82a0:
0xffff in
stead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x002a82a4:
0x0057 in............................

-----Original Message-----
From: linux-fsdevel-owner@vger.kernel.org
[mailto:linux-fsdevel-owner@vger.kernel.org] On Behalf Of Artem B.
Bityuckiy
Sent: Monday, April 25, 2005 1:57 PM
To: Mahur Mansi (IFIN SCC SMS)
Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: Mounting File System .


Mansi.Mahur@infineon.com wrote:
>  Hello to All,
>      I am facing problems like various warnings after giving mount 
> point for  jffs2 File System as  /tmp dir .
Please, post your warning. Post them better to the MTD list.

Before posting please explore carefully the 
http://www.linux-mtd.infradead.org Web site.

Which flash do you use? How did you prepare your JFFS2 image?

-- 
Best regards, Artem B. Bityuckiy
Oktet Labs (St. Petersburg), Software Engineer.
+78124286709 (office) +79112449030 (mobile)
E-mail: dedekind@oktetlabs.ru, web: http://www.oktetlabs.ru
-
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
