Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUAGKth (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 05:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265473AbUAGKth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 05:49:37 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:4252 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S265466AbUAGKte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 05:49:34 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: raid0_make_request bug: can't convert block across chunks or
 bigger than
References: <yw1xznd0ult1.fsf@ford.guide>
	<20040107023332.5ff0b9ff.akpm@osdl.org>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 07 Jan 2004 11:49:31 +0100
In-Reply-To: <20040107023332.5ff0b9ff.akpm@osdl.org> (Andrew Morton's
 message: 33:32 -0800")
Message-ID: <yw1xvfnouj7o.fsf@ford.guide>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> mru@kth.se (Måns Rullgård) wrote:
>>
>> I'm using Linux 2.6.0 on an Alpha SX164 machine.  Using four ATA
>>  disks, hd[egik], on a Highpoint hpt374 controller, I created two raid0
>>  arrays from hd[eg]1 and hd[ik]1, md0 and md1.  From these, I created a
>>  raid1 mirror, md4, on which I created an XFS filesystem.  For various
>>  reasons, I first ran md4 with only md0 as a member and filled it with
>>  some files, all going well.  Then, I added md1, and it was synced
>>  properly.  Now, I can mount md4 without problems.  However, when I
>>  read things, I get this in the kernel log:
>> 
>>  raid0_make_request bug: can't convert block across chunks or bigger than 32k 439200 32
>
> This was fixed post-2.6.0.  2.6.1-rc2 should be OK.

I just noticed.

>>  raid1: Disk failure on md1, disabling device. 
>>  	Operation continuing on 1 devices
>
> I assume this is due to the raid0 error above.

I should think so.

I'm still curious as to why it was only md1 that gave errors, and
never md0.  Was it just coincidence?

-- 
Måns Rullgård
mru@kth.se
