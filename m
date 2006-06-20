Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbWFTClK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbWFTClK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 22:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbWFTClJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 22:41:09 -0400
Received: from web33009.mail.mud.yahoo.com ([68.142.206.73]:8592 "HELO
	web33009.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965049AbWFTClI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 22:41:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=u9H76b817rt8qlh9Of5GOMCQmZDJrOhDDLxzVj9zhZfAFjE4UIlOJbuf/07QY39z8kSHam2L0hNpWRtmLIqf5mSmgDajvHmizB6V8ClYm21fSgLMYaG4aKfUmNbAp8fA/9NazWWfZiZnfqVLiPDBZggKNjw9zJAjsy0rFwiyTE8=  ;
Message-ID: <20060620024108.35131.qmail@web33009.mail.mud.yahoo.com>
Date: Mon, 19 Jun 2006 19:41:07 -0700 (PDT)
From: Stephen Cameron <smcameron@yahoo.com>
Subject: Problem with Sandisk USB CF reader on 2.6.16.20
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Probably this is somehow my idiocy, but...

I have a Sandisk USB compact flash reader.  this 
worked with 2.6.16.11, but does not seem to work with
2.6.16.20.  Maybe a udev problem?

[root@zuul ~]# udevinfo -V
udevinfo, version 039
[root@zuul ~]# lsmod | grep usb
usb_storage            58496  0
libusual               13072  1 usb_storage
usbcore               131780  5 usb_storage,libusual,uhci_hcd,ehci_hcd

I plug the device in, and cat /proc/partitions, but
see nothing matching my usb device.

I used the .config from my working 2.6.16.11 kernel
when making the 2.6.16.20 kernel...
(did "make oldconfig" iirc.)

My userland is from Fedora core 3, mostly...

One thing that's always been a little fuzzy to me...
when updating a kernel, how do I know what userland things
need updating?  e.g. my iptables I think doesn't work any 
more, also.

Thanks for any hints.

-- steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
