Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269430AbUINPGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269430AbUINPGR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269414AbUINPDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:03:33 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:11498 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S269416AbUINPBY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:01:24 -0400
From: Alistair John Strachan <alistair@devzero.co.uk>
Reply-To: alistair@devzero.co.uk
To: Steve Lord <lord@xfs.org>
Subject: Re: Copying huge amount of data on ReiserFS, XFS and Silicon Image 3112 cause oops.
Date: Tue, 14 Sep 2004 16:01:33 +0100
User-Agent: KMail/1.7
References: <414622C9.1030701@post.pl> <200409141159.54889.alistair@devzero.co.uk> <4146FC39.40104@xfs.org>
In-Reply-To: <4146FC39.40104@xfs.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409141601.33827.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 September 2004 15:12, you wrote:
[snip]
>
> You would need to be within the size of the physical memory of your
> box to having a full filesystem - as a very rough approximation. So 1Gbyte
> memory, 1 Gbyte disk free. There is a path when XFS is attempting to
> free up pre-reserved disk space to make room for a new write, it
> does this by flushing data out to disk. This means it has to work
> out where it is physically going to go, which usually results in it
> taking less metadata space to reference the data than the worst case
> estimate it previously made. For lots of cases this probably still
> does not overflow the stack, but if you add in drivers like lvm
> and md and a complex scsi driver it probably pushes you over the
> limit.
>

Well, this is a good reference answer to the question. The machines are all 
small systems with only 1GB memory, and plenty of remaining space on the two 
partitions. I doubt I'd trigger the logic causing the problem.

> In general though, I would rebuild without the 4K stacks and at least
> have the kernel ready for a convenient reboot.

Thanks, I'll do that.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
