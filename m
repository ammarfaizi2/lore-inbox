Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbUKQA6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbUKQA6V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 19:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbUKQA6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 19:58:21 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:56990 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262134AbUKQA6R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 19:58:17 -0500
Date: Wed, 17 Nov 2004 00:57:59 +0000
From: Willem Riede <osst@riede.org>
Subject: Re: [patch 0/4] Cleanup file_count usage
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kai Makisara <Kai.Makisara@metla.fi>, coda@cs.cmu.edu,
       Paul Mackerras <paulus@samba.org>
References: <20041116135200.GA23257@impedimenta.in.ibm.com>
In-Reply-To: <20041116135200.GA23257@impedimenta.in.ibm.com> (from
	kiran@in.ibm.com on Tue Nov 16 08:52:00 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1100653079l.11560l.1l@serve.riede.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/2004 08:52:00 AM, Ravikiran G Thirumalai wrote:
> This patchset is an attempt to cleanup some bogus and some not so bogus
> reads to struct file.f_count of the vfs from various subsystems in the
> kernel. This patchset doesn't cleanup uses of f_count completely;
> Geting rid of all reads to f_count was suggested by Viro during the
> discussion on kref based lockfree fd management sometime back.
> 
> What remains:
> 1. Hack to return error code to user space at last close through file_count
>    check at the driver's flush routine.  This hack is used in scsi/st.c,
>    scsi/osst.c and coda/file.c to return error code through .flush()
>    (Although it is doubtful if applications check for error during
>    close(2)).
>    Kai has a patch to cleanup scsi/st.c.

The equivalent change can easily be made to osst. I'll be happy to take
care of that if we collectively decide that's where we need to go.

Regards, Willem Riede.


