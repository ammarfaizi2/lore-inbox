Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVELTVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVELTVb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 15:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVELTVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 15:21:31 -0400
Received: from mail.ccur.com ([208.248.32.212]:38981 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S261386AbVELTV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 15:21:27 -0400
Subject: NFS: msync required for data writes to server?
From: Linda Dunaphant <linda.dunaphant@ccur.com>
Reply-To: linda.dunaphant@ccur.com
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: CCUR
Message-Id: <1115925686.6319.3.camel@lindad>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Thu, 12 May 2005 15:21:26 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 May 2005 19:21:27.0268 (UTC) FILETIME=[CB18FA40:01C55727]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

On our 2.6.9 based systems, data written using mmap(MAP_SHARED) on a NFS
client is *never* being pushed out to the server if an explicit msync call
is not issued before the munmap.

On 11/12/04, there was a message thread concerning NFS corruption when
using mmap/munmap:

http://marc.theaimsgroup.com/?l=linux-nfs&m=110028817508318&w=2

In this thread you stated:

     mmap() offers absolutely NO guarantees that the file will be synced to
     disk on close. Use msync(MS_SYNC) if you want such a guarantee.

Are you saying that the data will *never* be written to the server?  Could
you please clarify your position on this further? 

Thanks!
Linda


