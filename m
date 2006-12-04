Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937316AbWLDTgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937316AbWLDTgP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 14:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759457AbWLDTgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 14:36:15 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59746 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759442AbWLDTgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 14:36:14 -0500
Date: Mon, 4 Dec 2006 11:36:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Zach Brown'" <zach.brown@oracle.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove redundant iov segment check
Message-Id: <20061204113609.753069b9.akpm@osdl.org>
In-Reply-To: <000001c717c0$f82b5ea0$2589030a@amr.corp.intel.com>
References: <000001c717c0$f82b5ea0$2589030a@amr.corp.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006 08:26:36 -0800
"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:

> So it's not possible to call down to generic_file_aio_read/write with invalid
> iov segment.  Patch proposed to delete these redundant code.

erp, please don't touch that code.

The writev deadlock fixes which went into 2.6.17 trashed writev()
performance and Nick and I are slowly trying to get it back, while fixing
the has-been-there-forever pagefault-in-write() deadlock.

This is all proving very hard to do, and we don't need sweeping code
cleanups happening under our feet ;)

I'll bring those patches back in next -mm, but not very confidently.
