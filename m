Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275442AbRIZS2B>; Wed, 26 Sep 2001 14:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275454AbRIZS1v>; Wed, 26 Sep 2001 14:27:51 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:62664 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S275449AbRIZS1k>; Wed, 26 Sep 2001 14:27:40 -0400
From: James Washer <e2big@us.ibm.com>
Message-Id: <200109261827.f8QIRlk05044@crg8.beaverton.ibm.com>
Subject: Kernel text getting corrupted 
To: linux-kernel@vger.kernel.org
Date: Wed, 26 Sep 2001 11:27:47 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We've got a strange one. We're seeing system crashes where memory, including 
kernel text (executable) pages, is being corrupted. If you have any idea what 
might be causing this, or if you've seen this yourself, or if you have ideas 
on how to debug it, please let us know.

The corrupting data consist of 16  individual bytes, each at an 8-byte offset, 
8 byte aligned. (see data below for an example)

Here's the data...  The first column marks the offset within the page, the 2nd 
column is the corrupted data, the 3rd column is the expected/correct data
Note, that the 0->0 is likely also corruption, but happenned to overwrite a zero 
with a zero

0xca0 a0 24 =========
0xca8 c0 8b =========
0xcb0 12 8f =========
0xcb8 00 53 =========
0xcc0 22 04 =========
0xcc8 4d c0 =========
0xcd0 61 5b =========
0xcd8 69 57 =========
0xce0 74 c0 =========
0xce8 41 10 =========
0xcf0 00 18 =========
0xcf8 00 11 =========
0xd00 00 00
0xd08 00 24 =========
0xd10 10 83 =========
0xd18 4d 19 =========

FYI. 
Hardware is ~1GHz PIII, 512MB, UP, eepro100 nic, ide drives
Software linux2.4.8,no modules, eepro100,  only 512MB of swap, serial ports 
	are HEAVILY used.

please cc e2big@us.ibm.com and jbarkal@us.ibm.com ( if you don't mind )
-- 
Jim Washer

