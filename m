Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281926AbRLAWn1>; Sat, 1 Dec 2001 17:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281923AbRLAWnS>; Sat, 1 Dec 2001 17:43:18 -0500
Received: from ubermail.mweb.co.za ([196.2.53.169]:20496 "EHLO
	ubermail.mweb.co.za") by vger.kernel.org with ESMTP
	id <S281922AbRLAWnD>; Sat, 1 Dec 2001 17:43:03 -0500
Message-ID: <3C095F45.7010704@mweb.co.za>
Date: Sun, 02 Dec 2001 00:52:53 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
Reply-To: bonganilinux@mweb.co.za
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Compilation error on 2.5.1-pre4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't seen any report of this on the list yet, there
is an error on linux/drivers/ide/ataraid.c line number 104
static int ataraid_make_request (request_queue_t *q, int rw, struct 
buffer_head * bh)
{
	int minor;
	int retval;
	minor = MINOR(bh->b_rdev)>>SHIFT;
			^^^^
struct buffer_head in linux/include/linux/fs.h
does not have member b_rdev anymore. Its late
and I'm a bit _lazy_ know. I will look at the
code tomorrow.

-Bongani

