Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLODv0>; Thu, 14 Dec 2000 22:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLODvQ>; Thu, 14 Dec 2000 22:51:16 -0500
Received: from riker.dsl.inconnect.com ([209.140.76.229]:34368 "EHLO
	ns1.rikers.org") by vger.kernel.org with ESMTP id <S129314AbQLODvE>;
	Thu, 14 Dec 2000 22:51:04 -0500
Message-ID: <3A398E0A.A12F973E@Rikers.org>
Date: Thu, 14 Dec 2000 20:20:42 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18pre21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: loop device length
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

losetup allows for setting a starting offset within a file for the loop
block device. There however is no length parameter to permit setting the
length. Adding a length parameter would allow for multiple fs images in
a single file (or device) and would correctly handle programs like
resize2fs.

What do you think? We could add a lo_length to struct loop_device and
return that if it was non-zero and less than the physical length
calculated normally by figure_loop_size().

While I'm at it why are loop_sizes[] and loop_blksizes[] not part of
struct loop_device now?
-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
