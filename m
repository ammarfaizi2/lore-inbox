Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265441AbTLSFE2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 00:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265446AbTLSFE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 00:04:28 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:28642 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S265441AbTLSFE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 00:04:26 -0500
Date: Fri, 19 Dec 2003 05:04:25 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 incorrect memory sizing (without a full BIOS)..
Message-ID: <Pine.LNX.4.58.0312190451210.9093@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
	I've got an internal development board based on the Intel 815
chipset and the Intel ACSFL mini-BIOS for embedded systems, and then using
grub 0.93 to boot Linux.

under 2.4 my memory is correctly sized at 256MB, but under 2.6 I'm only
seeing 64MB,

2.6 gives:
BIOS-provided physical RAM map:
 BIOS-88: 0000000000000000 - 000000000009f000 (usable)
 BIOS-88: 0000000000100000 - 00000000040ffc00 (usable)
64MB LOWMEM available

2.4 gives:
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000e0000 - 0000000000100000 type 5
 BIOS-e820: 0000000000100000 - 000000000ff00000 (usable)
 BIOS-e820: 000000000ff00000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 type 6
 BIOS-e820: 00000000fee00000 - 00000000fee00400 type 7
 BIOS-e820: 00000000fff00000 - 0000000100000000 type 5

So is this 2.6 just being more fussy about the contents of the e820 that
my "BIOS" is supplying and falling back to the old style detection?

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

