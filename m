Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130584AbRCIPm4>; Fri, 9 Mar 2001 10:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130585AbRCIPmq>; Fri, 9 Mar 2001 10:42:46 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:52240
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S130584AbRCIPmd>; Fri, 9 Mar 2001 10:42:33 -0500
Date: Fri, 09 Mar 2001 10:41:01 -0500
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org, alan@redhat.com, viro@math.psu.edu
Subject: 2.4.2-ac calls FS truncate w/o BKL
Message-ID: <890000000.984152461@tiny>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The added vmtruncate calls in the ac series trigger calls to the FS
truncate without the BKL held.  Easy enough to fix on the reiserfs side,
but if other filesystems care we might want to change vmtruncate to grab
the lock before calling truncate (and update the Locking doc ;-)

-chris
