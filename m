Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVBHWrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVBHWrD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 17:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVBHWrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 17:47:03 -0500
Received: from hera.kernel.org ([209.128.68.125]:15277 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261676AbVBHWon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 17:44:43 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: where to export system tuneables, /proc/sys/kernel or /sys/?
Date: Tue, 8 Feb 2005 22:44:25 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cubfc9$2th$1@terminus.zytor.com>
References: <4207A395.1060901@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1107902665 2994 127.0.0.1 (8 Feb 2005 22:44:25 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 8 Feb 2005 22:44:25 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <4207A395.1060901@nortel.com>
By author:    Chris Friesen <cfriesen@nortel.com>
In newsgroup: linux.dev.kernel
>
> I'm doing some kernel work that will export tuneables to userspace.  In 
> 2.4 I would have used /proc/sys/kernel, but now there is /sys, which was 
> supposed to be for system information.
> 
> However, a bit of poking around in /sys didn't reveal any obvious place 
> to put it.  Is current practice to still put this sort of thing in /proc?
> 

/proc/sys/kernel, using the sysctl internals, yes.

Note that the use of the sysctl(2) system call is highly deprecated,
but the /proc/sys filesystem tree is not; the reason is that the
numeric API used by the former is unstable.

	-hpa
