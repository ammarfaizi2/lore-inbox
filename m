Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbTDLW2b (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 18:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbTDLW2b (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 18:28:31 -0400
Received: from ms-smtp-01.tampabay.rr.com ([65.32.1.43]:10461 "EHLO
	ms-smtp-01.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S261282AbTDLW2a (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 18:28:30 -0400
Message-ID: <001301c30145$5ff85fb0$6801a8c0@epimetheus>
From: "Timothy Miller" <tmiller10@cfl.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: Benefits from computing physical IDE disk geometry?
Date: Sat, 12 Apr 2003 18:46:36 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm excited about the new I/O scheduler (proposed?) in the 2.5.x kernel, but
I have to admit to a considerable amount of ignorance of its actual
behavior.  Thus, if it already does what I'm talking about, please feel free
to ignore this post.  :)


Any good SCSI drive knows the physical geometry of the disk and can
therefore optimally schedule reads and writes.  Although necessary features,
like read queueing, are also available in the current SATA spec, I'm not
sure most drives will implement it, at least not very well.

So, what if one were to write a program which would perform a bunch of
seek-time tests to estimate an IDE disk's physical geometry?  It could then
make that information available to the kernel to use to reorder accesses
more optimally.  Additionally, discrepancies from expected seek times could
be logged in the kernel and used to further improve efficiency over time.
If it were good enough, many of the advantages of using SCSI disks would
become less significant.

Ideas?



