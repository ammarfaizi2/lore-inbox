Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264867AbTLQXZo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 18:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264870AbTLQXZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 18:25:39 -0500
Received: from chico.cs.colostate.edu ([129.82.45.30]:61384 "EHLO
	chico.cs.colostate.edu") by vger.kernel.org with ESMTP
	id S264867AbTLQXZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 18:25:30 -0500
X-WebMail-UserID: jshankar@cs.colostate.edu
Date: Wed, 17 Dec 2003 16:25:11 -0700
From: jshankar <jshankar@CS.ColoState.EDU>
To: "Richard B. Johnson" <root@chaos.analogic.com>,
       Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
X-EXP32-SerialNo: 00002247, 00002264
Subject: RE: ext3 file system
Message-ID: <3FF18FD8@webmail.colostate.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Infinite Mobile Delivery (Hydra) SMTP v3.62.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please provide some more insight.

Suppose a filesystem issues a write command to the disk with around 10 4K 
Blocks  to be written. SCSI device point of view i don't get what is the 
parallel I/O.
It has only 1 write command. If some other sends a write request it needs to 
be queued. But the next question arises how the write data would be handled. 
Does it mean the SCSI does not give a response for the block of data written. 
In otherwords does it mean that the response would be given after all the 
block of data is written for a single write request.
 
Thanks
Jay




>===== Original Message From Mike Fedyk <mfedyk@matchmail.com> =====
>On Wed, Dec 17, 2003 at 05:25:49PM -0500, Richard B. Johnson wrote:
>> to the physical media. There are special file-systems (journaling)
>> that guarantee that something, enough to recover the data, is
>> written at periodic intervals.
>
>Most journaling filesystems make guarantees on the filesystem meta-data, but
>not on the data.  Some like ext3, and reiserfs (with suse's journaling
>patch) can journal the data, or order things so that the data is written
>before any pointers (ie meta-data) make it to the disk so it will be harder
>to loose data.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

