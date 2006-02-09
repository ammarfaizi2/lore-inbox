Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965207AbWBIJCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965207AbWBIJCz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 04:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbWBIJCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 04:02:55 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:18051 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S965230AbWBIJCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 04:02:53 -0500
Date: Thu, 9 Feb 2006 10:02:44 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: John Schmerge <schmerge@speakeasy.net>
cc: 7eggert@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: Question regarding /proc/<pid>/fd and pipes
In-Reply-To: <Pine.LNX.4.58.0602081912160.25842@shell3.speakeasy.net>
Message-ID: <Pine.LNX.4.58.0602090959450.2152@be1.lrz>
References: <5DRW7-322-1@gated-at.bofh.it> <E1F6qZR-0002uc-Kc@be1.lrz>
 <Pine.LNX.4.58.0602081912160.25842@shell3.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006, John Schmerge wrote:

> Thanks for the answer... I've got one more question: will the symlinks
> to the pipe be the same for both the read and write ends in all
> processes sharing the pipe?

It seems like yes. You can find it out by sinply trying it out.

> I've got some sort of funky race condition occurring between the read
> from the pipe and the exiting of the process on the write-end of the pipe...
> The read-process is supposed to exit after the write-process finishes
> (and does in about 1/2 the time), but I think I'm seeing the read-process
> blocked by something even after the write-process completes... Both top
> and ps give no indication that the read-process is blocked on a read(2).
> I've got some digging to do, but I'm thinking that this might actually be
> a kernel bug.

Do you close() the writing end in the process that's supposed to read?
-- 
Top 100 things you don't want the sysadmin to say:
98. What the hell!?
