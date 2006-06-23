Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751747AbWFWQWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbWFWQWT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 12:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbWFWQWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 12:22:19 -0400
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:50046 "HELO
	web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751747AbWFWQWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 12:22:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=uSzTRe/iO0zB1dSSWxdbx2HpDLV4p/0dvOpuVsE+ujXiwkRczIu0GH/hsSW9ruFWqBoEXzy3M4w4PYNpqL+dVELghcvBr/oGGgD7PoSr1Z7XBbHFH6IRoAgkIo1YO3xZK/a5RRxLAJb7E7n7DbG4HJF2gEiDrcGcUW1n4yw2dyY=  ;
Message-ID: <20060623162217.58559.qmail@web31809.mail.mud.yahoo.com>
Date: Fri, 23 Jun 2006 09:22:17 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: slab corruption warnings
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.6.17 at e752c9c9d83e86ff9da1d1adc7fef5d8fdb219ce.

Plug in a disk (USB key) and see this:

Slab corruption: start=ffff81007c0666b0, len=1024
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff804cee45>](skb_release_data+0x88/0x8d)
2a0: 48 3d 05 6d 00 81 ff ff 6b 6b 6b 6b 6b 6b 6b 6b
Prev obj: start=ffff81007c066298, len=1024
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff804cee45>](skb_release_data+0x88/0x8d)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=ffff81007c066ac8, len=1024
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<ffffffff8048c7ab>](atkbd_connect+0x22/0x277)
000: e8 d8 2d 7c 00 81 ff ff 01 00 00 00 00 00 00 00
010: 01 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00

   Luben


