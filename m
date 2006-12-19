Return-Path: <linux-kernel-owner+w=401wt.eu-S1754797AbWLSHJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797AbWLSHJF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 02:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754767AbWLSHJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 02:09:05 -0500
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:44463 "EHLO
	liaag2ad.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754799AbWLSHJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 02:09:04 -0500
Date: Tue, 19 Dec 2006 02:02:14 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Aiee, killing interrupt handler!
To: Hawk Xu <hxunix@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-ID: <200612190205_MC3-1-D591-6D90@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <4587653C.1080100@gmail.com>

On Tue, 19 Dec 2006 12:06:20 +0800, Hawk Xu wrote:

> Our server(running Oracle 10g) is having a kernel panic problem:
<> 
> Process swapper (pid: 0, threadinfo ffffffff80582000, task ffffffff80464300)
> Stack: 0000000000000296 ffffffff8013f325 ffff81007f7f54d0 0000000000000100
>        0000000000000001 000000000000000e ffffffff8053e098 ffffffff8013f3a5
>        ffff81007f7f54d0 ffff810002c10a20

You need to post the entire oops message, not just the last part.  It should
start with "BUG". And using a more recent kernel would be a good idea.

> And, we have these error messages in the /var/log/kernel file:
> 
> Dec  7 17:19:09 kf85-1 kernel: set_local_var[9683]: segfault at
> 00000000fffffffc rip 0000000055f41d69 rsp 00000000ffffc4e8 error 6
> Dec  7 17:27:44 kf85-1 kernel: set_local_var[12020]: segfault at
> 00000000fffffffc rip 0000000055f41d69 rsp 00000000ffffb978 error 6

32-bit Oracle on 64-bit kernel?  If so, it's probably not going to work.

-- 
MBTI: IXTP
