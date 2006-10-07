Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423073AbWJGCqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423073AbWJGCqJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 22:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423071AbWJGCqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 22:46:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62912 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423070AbWJGCqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 22:46:05 -0400
Date: Fri, 6 Oct 2006 19:45:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Suzuki K P <suzuki@in.ibm.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>,
       lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       andmike@us.ibm.com
Subject: Re: [RFC] Fix check_partition routines ( was Re: [RFC] PATCH to fix
 rescan_partitions to return errors properly - take 2)
Message-Id: <20061006194550.8351ed5e.akpm@osdl.org>
In-Reply-To: <452706EA.3040702@in.ibm.com>
References: <452307B4.3050006@in.ibm.com>
	<20061004130932.GC18800@harddisk-recovery.com>
	<4523E66B.5090604@in.ibm.com>
	<20061004170827.GE18800@harddisk-recovery.nl>
	<4523F16D.5060808@in.ibm.com>
	<20061005104018.GC7343@harddisk-recovery.nl>
	<45256BE2.5040702@in.ibm.com>
	<20061006125336.GA27183@harddisk-recovery.nl>
	<452695CE.8080901@in.ibm.com>
	<20061006210721.GC31233@harddisk-recovery.nl>
	<452706EA.3040702@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Oct 2006 18:46:18 -0700
Suzuki K P <suzuki@in.ibm.com> wrote:

> *  The check_partition() stops its probe once it hits an I/O error from the partition checkers. This would prevent the actual partition checker getting a chance to verify the partition. So, this patch lets the check_partition continue probing untill it hits a success while recording the I/O error which might have been reported by the checking routines.
> 
> Also, it does some cleanup of the partition methods for ibm, atari and amiga to return -1 upon hitting an I/O error.

What is the significance of a `return 1', a `return 0' and a `return -EFOO' in these
functions?  It all looks rather odd.
