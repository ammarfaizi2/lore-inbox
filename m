Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273709AbRJBPqD>; Tue, 2 Oct 2001 11:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275389AbRJBPpz>; Tue, 2 Oct 2001 11:45:55 -0400
Received: from gap.cco.caltech.edu ([131.215.139.43]:5825 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S275423AbRJBPpl>; Tue, 2 Oct 2001 11:45:41 -0400
Date: Tue, 02 Oct 2001 16:32:50 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Dinesh Gandhewar <dinesh_gandhewar@rediffmail.com>,
        mlist-linux-kernel@nntp-server.caltech.edu
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: 
Message-ID: <714723117.1002040370@[10.132.113.67]>
In-Reply-To: <20011002152945.15180.qmail@mailweb16.rediffmail.com>
In-Reply-To: <20011002152945.15180.qmail@mailweb16.rediffmail.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Tuesday, October 02, 2001 3:29 PM +0000 Dinesh  Gandhewar 
<dinesh_gandhewar@rediffmail.com> wrote:

> In this module I have declared an array of size 2048. If I use this
> array, the execution of this module function causes kernel to reboot. If
> I kmalloc() this array then execution of this module function doesnot
> cause any problem.

If you are allocating it on the stack (i.e. as a local variable)
you are probably running out of kernel stack space (depending
what it's an array of).

If you are declaring it non-local, it's possible you are
overwriting the end of it, and, kmalloc() being what it
is, there happens to be some wasted space next to it.

--
Alex Bligh
