Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264993AbTFLUym (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 16:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbTFLUym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 16:54:42 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:1471 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id S264993AbTFLUyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 16:54:41 -0400
Date: Thu, 12 Jun 2003 16:08:18 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix vmtruncate race and distributed filesystem race
Message-ID: <150040000.1055452098@baldur.austin.ibm.com>
In-Reply-To: <20030612140014.32b7244d.akpm@digeo.com>
References: <133430000.1055448961@baldur.austin.ibm.com>
 <20030612134946.450e0f77.akpm@digeo.com>
 <20030612140014.32b7244d.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, June 12, 2003 14:00:14 -0700 Andrew Morton <akpm@digeo.com>
wrote:

> And this does require that ->nopage be entered with page_table_lock held,
> and that it drop it.

I think that's a worse layer violation than referencing inode in
do_no_page.  We shouldn't require that the filesystem layer mess with the
page_table_lock.

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

