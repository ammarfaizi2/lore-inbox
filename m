Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268116AbUHQFXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268116AbUHQFXT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 01:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268117AbUHQFXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 01:23:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:31684 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268116AbUHQFXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 01:23:17 -0400
Date: Tue, 17 Aug 2004 07:23:02 +0200
From: Olaf Hering <olh@suse.de>
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: /bin/ls: cannot read symbolic link /proc/$$/exe: Permission denied
Message-ID: <20040817052302.GA11448@suse.de>
References: <20040816133730.GA6463@suse.de> <20040816223938.GA9133@suse.de> <je4qn28xoq.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <je4qn28xoq.fsf@sykes.suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Aug 17, Andreas Schwab wrote:

> Olaf Hering <olh@suse.de> writes:
> 
> >  On Mon, Aug 16, Olaf Hering wrote:
> >
> >> 
> >> For some reasons ls -l /proc/$$/exe doesnt work all time for me,
> >> with 2.6.8.1 on ppc64. Sometimes it does, sometimes not. No pattern.
> >> A few printks show that this check in proc_pid_readlink() triggers
> >> an -EACCES:
> >> 
> >>         current->fsuid != inode->i_uid
> >> 
> >> proc_pid_readlink(755) error -13 ntptrace(11408) fsuid 100 i_uid 0 0
> >> sys_readlink(281) ntptrace(11408) error -13 readlink
> >
> > A better one, clear both new fields, just in case.
> 
> memset?

perhaps too expensive, no idea.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
