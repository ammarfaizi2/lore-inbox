Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266461AbUHPXeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266461AbUHPXeT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 19:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUHPXeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 19:34:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:49866 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266461AbUHPXeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 19:34:15 -0400
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: /bin/ls: cannot read symbolic link /proc/$$/exe: Permission
 denied
References: <20040816133730.GA6463@suse.de> <20040816223938.GA9133@suse.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Do you guys know we just passed thru a BLACK HOLE in space?
Date: Tue, 17 Aug 2004 01:34:13 +0200
In-Reply-To: <20040816223938.GA9133@suse.de> (Olaf Hering's message of "Tue,
 17 Aug 2004 00:39:38 +0200")
Message-ID: <je4qn28xoq.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olh@suse.de> writes:

>  On Mon, Aug 16, Olaf Hering wrote:
>
>> 
>> For some reasons ls -l /proc/$$/exe doesnt work all time for me,
>> with 2.6.8.1 on ppc64. Sometimes it does, sometimes not. No pattern.
>> A few printks show that this check in proc_pid_readlink() triggers
>> an -EACCES:
>> 
>>         current->fsuid != inode->i_uid
>> 
>> proc_pid_readlink(755) error -13 ntptrace(11408) fsuid 100 i_uid 0 0
>> sys_readlink(281) ntptrace(11408) error -13 readlink
>
> A better one, clear both new fields, just in case.

memset?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
