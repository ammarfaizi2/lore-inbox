Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267623AbTBUSRj>; Fri, 21 Feb 2003 13:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267624AbTBUSRj>; Fri, 21 Feb 2003 13:17:39 -0500
Received: from vbws78.voicebs.com ([66.238.160.78]:6674 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S267623AbTBUSRi>; Fri, 21 Feb 2003 13:17:38 -0500
Message-ID: <3E566F9C.7010406@didntduck.org>
Date: Fri, 21 Feb 2003 13:27:40 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nataraja kumar <hainattu@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: A question on kernel stack
References: <20030221180508.18214.qmail@web20206.mail.yahoo.com>
In-Reply-To: <20030221180508.18214.qmail@web20206.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nataraja kumar wrote:
> hi,
> my apologies if i am wrong. please let me know
> why does kernel use kernel stack when process jumps
> from user mode to kernel mode. why can't user stack
> be used ?
> 
> nattu.

1) The user stack could be invalid.  An invalid stack in the kernel will 
cause the processor to double fault (see the recent double fault thread).
2) Security.  You could set up the stack pointer from userspace so that 
the kernel would overwrite memory that userspace can't access.
3) Security #2.  You don't want to give userspace access to certain data 
written to the stack in kernel mode.

--
				Brian Gerst

