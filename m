Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbVKKTto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVKKTto (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbVKKTto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:49:44 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:21224 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751120AbVKKTtm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:49:42 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17268.62897.434122.165183@tut.ibm.com>
Date: Fri, 11 Nov 2005 13:49:05 -0600
To: Christoph Hellwig <hch@infradead.org>
Cc: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, karim@opersys.com
Subject: Re: [PATCH 2/12] relayfs: export relayfs_create_file() with fileops param
In-Reply-To: <20051111193749.GA17018@infradead.org>
References: <17268.51814.215178.281986@tut.ibm.com>
	<17268.51975.485344.880078@tut.ibm.com>
	<20051111193749.GA17018@infradead.org>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
 > On Fri, Nov 11, 2005 at 10:47:03AM -0600, Tom Zanussi wrote:
 > > This patch adds a mandatory fileops param to relayfs_create_file() and
 > > exports that function so that clients can use it to create files
 > > defined by their own set of file operations, in relayfs.  The purpose
 > > is to allow relayfs applications to create their own set of 'control'
 > > files alongside their relay files in relayfs rather than having to
 > > create them in /proc or debugfs for instance.  relayfs_create_file()
 > > is also used by relay_open_buf() to create the relay files for a
 > > channel.  In this case, a pointer to relayfs_file_operations is passed
 > > in, along with a pointer to the buffer associated with the file.
 > 
 > Again, NACK,  control files don't belong into relayfs.
 > 

Sure, applications could just as easily create these same files in
/proc, /sys, or /debug, but since relayfs is a filesystem, too, it
seems to me to make sense to take advantage of that and allow them to
be created alongside the relay files they're associated with, in
relayfs.

Tom


