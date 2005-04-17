Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVDQT1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVDQT1c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 15:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVDQTYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 15:24:40 -0400
Received: from vv.carleton.ca ([134.117.172.80]:706 "EHLO vv.carleton.ca")
	by vger.kernel.org with ESMTP id S261425AbVDQTXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 15:23:38 -0400
Date: Sun, 17 Apr 2005 15:23:38 -0400 (EDT)
From: Catalin Patulea <cat@vv.carleton.ca>
To: linux-kernel@vger.kernel.org
Subject: Reading kmem
Message-ID: <Pine.LNX.4.60.0504171434180.4037@vv.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm having trouble reading from /dev/kmem in Linux 2.4.22 and 2.4.25. I 
have written some code available at 
http://vv.carleton.ca/~cat/misc/readidt.c. The behavior on both kernel 
versions is the following:

# ./readidt
idt: 0xffffe000 + 0x07ff
pointer at 0x00000000ffffe400
read: 0

As read returns 0, it seems as if it's reading past the end of file. 
However, the IDT must be present in the kernel's virtual memory. Also, 
looking at 2.4.20's read_kmem() (drivers/char/mem.c:215), I don't see how 
the function could return 0 unless count was 0.

It would be great if follow-ups could be CC'ed to my e-mail address.

Thank you very much for your time,
Catalin

-----------------------------------------
Catalin Patulea       VV Volunteer 2002,3
http://vv.carleton.ca/~cat/    VV HI 2004
cat@vv.carleton.ca
