Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946193AbWJSQXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946193AbWJSQXb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946197AbWJSQXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:23:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:8128 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946193AbWJSQX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:23:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:from:content-type:message-id:user-agent:mime-version:content-transfer-encoding;
        b=ZSXJm0t3mECOES+VJRRih1h+iNFgctYWEN0VqoYMbvLi7ZJywffOsTs6cxGB8PvcqvL4sbz8xB8xKx44tWFjvSezV10un69a0M3XmidK37u3zn9TrX1NnjaENNoOC2mwJJu+28cCUqLRIZ3V+VE+3vlmbOK0jmbkU8XQPU8ZwLA=
Date: Thu, 19 Oct 2006 11:23:11 -0500
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [im]proper use of stack?
From: mfbaustx <mfbaustx@gmail.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Message-ID: <op.thofmaaanwjy9v@titan.bintz-dev.net>
User-Agent: Opera Mail/9.01 (Win32)
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So... I know that there is some small-ish amount of kernel stack space  
available per-process, and the kernel uses this area when executing on a  
process's behalf (system call, etc).  Let's say I allocate (via an  
automatic/stack-based storage) some smallish structure which I want a  
kernel thread to populate (or interrupt context... some context other than  
my process's context).

If my process gets context swapped, is my kernel-based stack pointer  
always valid?

Why use stack-based storage, you ask?  Let's pretend this is a  
high-frequency call and I don't want to incur the expense of kmalloc'ing  
and freeing on every call.  I know I have enough stack space, I just don't  
know if my stack is always available  :)

TIA!
