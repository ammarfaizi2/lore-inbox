Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751618AbWEZVjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbWEZVjV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 17:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbWEZVjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 17:39:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47520 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751616AbWEZVjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 17:39:20 -0400
Date: Fri, 26 May 2006 17:39:15 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: .17rc5 cfq slab corruption.
Message-ID: <20060526213915.GB7585@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Was playing with googles new picasa toy, which hammered the disks
hunting out every image file it could find, when this popped out:

Slab corruption: (Not tainted) start=ffff810012b998c8, len=168
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff8032c319>](cfq_free_io_context+0x2f/0x74)
090: 10 bd 28 1b 00 81 ff ff 6b 6b 6b 6b 6b 6b 6b 6b
Prev obj: start=ffff810012b99808, len=168
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff8032c319>](cfq_free_io_context+0x2f/0x74)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=ffff810012b99988, len=168
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff8032c319>](cfq_free_io_context+0x2f/0x74)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

		Dave

-- 
http://www.codemonkey.org.uk
