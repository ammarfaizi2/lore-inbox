Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWJEWIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWJEWIT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 18:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWJEWIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 18:08:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34996 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932332AbWJEWIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 18:08:17 -0400
Date: Thu, 5 Oct 2006 15:07:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Suzuki Kp <suzuki@in.ibm.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>,
       lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       andmike@us.ibm.com
Subject: Re: [RFC] PATCH to fix rescan_partitions to return errors properly
  - take 2
Message-Id: <20061005150729.170e41c4.akpm@osdl.org>
In-Reply-To: <45256BE2.5040702@in.ibm.com>
References: <452307B4.3050006@in.ibm.com>
	<20061004130932.GC18800@harddisk-recovery.com>
	<4523E66B.5090604@in.ibm.com>
	<20061004170827.GE18800@harddisk-recovery.nl>
	<4523F16D.5060808@in.ibm.com>
	<20061005104018.GC7343@harddisk-recovery.nl>
	<45256BE2.5040702@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2006 13:32:34 -0700
Suzuki Kp <suzuki@in.ibm.com> wrote:

> Erik,
> 
> 
> Erik Mouw wrote:
> > On Wed, Oct 04, 2006 at 10:37:49AM -0700, Suzuki Kp wrote:
> > 
> >>Erik Mouw wrote:
> >>
> >>>I disagree. It's perfectly valid for a disk not to have a partition
> >>>table (for example: components of a RAID5 MD device) and we shouldn't
> >>>scare users about that. Also an unrecognised partition table format
> >>>(DEC VMS, Novell Netware, etc.) is not a reason to throw an error, it's
> >>>just unrecognised and as far as the kernel knows it's unpartioned.
> >>
> 
> [...]
> 
> 
> Thank you very much for the inputs.
> 
> As per the discussion I have made the changes to the patch.
> 
> This change needs to be implemented in some of the partition checkers 
> which doesn't do that already.
> 
> Btw, do you think it is a good idea to let the other partition checkers 
> run, even if one of them has failed ?
> 
> Right now, the check_partition runs the partition checkers in a 
> sequential manner, until it finds a success or an error.

This is all important information to capture in the patch changelog: it
covers user-visible changes, it covers user-affecting problems with the
present kernel, it describes the implications of making this change to the
kernel, etc.  All important stuff.  So could you please send a complete
changelog for this patch?


>
> * Fix rescan_partition to propagate the low level I/O error.
>

Not enough ;)
 
> 
> 
> Signed Off by: Suzuki K P <suzuki@in.ibm.com>
> 

Please use "Signed-off-by:"

This patch had tabs replaced with spaces, despite the fact that it was an
attachment - that's a new one.  Please get that fixed up for future
patches, thanks.

