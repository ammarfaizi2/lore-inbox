Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131767AbQLQJDR>; Sun, 17 Dec 2000 04:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131061AbQLQJDH>; Sun, 17 Dec 2000 04:03:07 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:62226 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131767AbQLQJCy> convert rfc822-to-8bit;
	Sun, 17 Dec 2000 04:02:54 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: nbreun@gmx.de
cc: f5ibh <f5ibh@db0bm.ampr.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test13-pre2, unresolved symbols 
In-Reply-To: Your message of "Sun, 17 Dec 2000 09:22:04 BST."
             <00121709220400.00938@nmb> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Date: Sun, 17 Dec 2000 19:32:19 +1100
Message-ID: <1408.977041939@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Dec 2000 09:22:04 +0100, 
Norbert Breun <nbreun@gmx.de> wrote:
>having applied your patch below + modutils2.3.23-1 + kernel2.4.0-test13pre2 
>all seems to run perfect. 
>But when starting kwintv  /dev/video is not found. /dev/video is a symling on 
>/dev/video0 and with kernel kernel2.4.0-test12 there is no problem at all.
>
>>can't open /dev/video: Kein passendes Gerät gefunden

"No suitable device found", -ENODEV.  The video driver has not been
loaded or has not been initialised correctly.  Compare the dmesg output
from 2.4.0-test12 and 0-test13-pre2 to see what is different.  It might
be a side effect of Linus's Makefile reordering.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
