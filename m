Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbTEEDCN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 23:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbTEEDCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 23:02:13 -0400
Received: from terminus.zytor.com ([63.209.29.3]:28128 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261923AbTEEDCM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 23:02:12 -0400
Message-ID: <3EB5D718.4050101@zytor.com>
Date: Sun, 04 May 2003 20:14:32 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
References: <200305041956_MC3-1-375E-31DB@compuserve.com>
In-Reply-To: <200305041956_MC3-1-375E-31DB@compuserve.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
>>There is another issue: x86 uses relative jumps, so although "ASCII
>>armor" addresses aren't easily accessible using return address smashes
>>(although the \0 at the end thing is a real issue), you may be able to
>>get to them through a jump instruction.
> 
>  Does the instruction-pointer-relative data addressing mode added by
> AMD64 make these exploits easier?  Maybe someone should be working on a
> version of this patch for that platform...
> 

No, they don't, not if your mode of exploit is hacking return addresses 
on the stack.

AMD64 makes this pretty easy, *ALL* user-space addresses are in the 
"ASCII armour" area, and it supports exec-off.  Apparently this is 
currently off by default, but Andi Kleen says that they have identified 
the bug that caused it and they're making it available as a kernel option.

	-hpa

