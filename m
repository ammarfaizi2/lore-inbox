Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVF1GkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVF1GkH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVF1Gjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:39:37 -0400
Received: from [213.184.188.19] ([213.184.188.19]:6660 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S262013AbVF1Ghu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 02:37:50 -0400
Message-Id: <200506280637.JAA07320@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>
Subject: RE: reiser4 plugins
Date: Tue, 28 Jun 2005 09:37:24 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <42C05F16.5000804@xfs.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Thread-Index: AcV7VVlEB06iPAm0R0SOBxzhNMKQcAAU5UMQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Steve, there is a remark about XFS below which you are going to be 
> more expert on.
> 
> Theodore Ts'o wrote:
> 
>>
>>XFS has similar issues where it assumes that hardware has powerfail 
>>interrupts, and that the OS can use said powerfail interrupt to stop 
>>DMA's in its tracks on an power failure, so that you don't have 
>>garbage written to key filesystem data structures when the memory 
>>starts suffering from the dropping voltage on the power bus faster 
>>than the DMA engine or the disk drives.  So XFS is a great filesystem
>>--- but you'd better be running it on a UPS, or on a system which has 
>>power fail interrupts and an OS that knows what to do.  Ext3, because 
>>it does physical block journalling, does not suffer from this problem.
>>(Yes, Resierfs uses logical journalling as well, so it suffers from 
>>the same problem.)
>>

True now, not so around 2.4.20 when XFS was rock-solid. I think they tried
to improve on performance and broke something. I wish they would fix that
because it forced me back to ext3, as in consistency over performance any
time.



