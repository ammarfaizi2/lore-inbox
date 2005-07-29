Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVG2Ajg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVG2Ajg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 20:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVG2Ajc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 20:39:32 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:49352 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262248AbVG2Aj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 20:39:28 -0400
From: Grant Coady <lkml@dodo.com.au>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Linux 2.4.32-pre2
Date: Fri, 29 Jul 2005 10:39:19 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <3buie15rb5r68jcgsh8e47dk8ifl8jmqvg@4ax.com>
References: <20050727080512.GD7368@dmt.cnet> <2i7he1lgg2237n66ec5p3e007tdsjos531@4ax.com> <20050728102225.GA7661@dmt.cnet>
In-Reply-To: <20050728102225.GA7661@dmt.cnet>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005 07:22:25 -0300, Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>> 
>> Breaks Toshiba laptop: hard lockup --> what is on screen is same as 
>> working dmesg up to point: "host/uhci.c: detected 2 port"
>> 
>> Same .config as for 2.4.31-hf3 or 2.4.32-pre1
>> http://scatter.mine.nu/test/linux-2.4/tosh/
>
>Please try to revert the attached? 

Yes, that fixed it :o) a USB mouse works.

dmesg:
...
host/uhci.c: detected 2 ports         <<== previous lockup after this
usb.c: kmalloc IF c12f36e0, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI-alt Root Hub
SerialNumber: ff80
...

And the other USB driver (usb-uhci) didn't lockup.

Thanks,
Grant.

