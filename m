Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbUKFT4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbUKFT4m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 14:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbUKFT4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 14:56:42 -0500
Received: from 76.80-203-227.nextgentel.com ([80.203.227.76]:35037 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S261454AbUKFT4l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 14:56:41 -0500
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: shmem_file_setup not exported
References: <Pine.LNX.4.44.0411061937370.4000-100000@localhost.localdomain>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Sat, 06 Nov 2004 20:56:40 +0100
In-Reply-To: <Pine.LNX.4.44.0411061937370.4000-100000@localhost.localdomain> (Hugh
 Dickins's message of "Sat, 6 Nov 2004 19:42:55 +0000 (GMT)")
Message-ID: <yw1x1xf6oio7.fsf@ford.inprovide.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> writes:

> On Sat, 6 Nov 2004, Måns Rullgård wrote:
>> I noticed this change in mm/shmem.c:
>> 
>> -EXPORT_SYMBOL(shmem_file_setup);
>> 
>> Is there a reason for this, other than nobody using it?
>
> That's the reason hch rightly removed the export, yes.
> ipc/shm.c does use it, but it's never a module, so doesn't need export.
> No other reason, beyond that it's appropriate to minimize exports.
> If you want to use it from your module, just patch the export back.

That makes using the module more complicated.  I don't really care
much, I'm not actively using the module.  I was just wondering whether
using it was incredibly silly for some reason.

-- 
Måns Rullgård
mru@inprovide.com
