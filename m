Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751597AbWHAMgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbWHAMgm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 08:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbWHAMgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 08:36:41 -0400
Received: from mail.aknet.ru ([82.179.72.26]:17415 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751538AbWHAMgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 08:36:41 -0400
Message-ID: <44CF4B84.6010409@aknet.ru>
Date: Tue, 01 Aug 2006 16:39:32 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: "akpm@osdl.org" <akpm@osdl.org>, zach@vmware.com, rohitseth@google.com,
       JBeulich@novell.com, ak@muc.de,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: + espfix-code-cleanup.patch added to -mm tree
References: <200607312226_MC3-1-C6A9-1757@compuserve.com>
In-Reply-To: <200607312226_MC3-1-C6A9-1757@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Chuck Ebbert wrote:
> we are on a ring0 32-bit stack that's not zero-based.  If an exception
> occurs in that state, UNWIND_ESPFIX_STACK restores the proper kernel
> SS and ESP but on return from the exception nothing restores the espfix
> stack.  I guess this isn't a problem now because exceptions in kernel
> mode are fatal but a kernel debugger might have problems here?
Perhaps you are right, but... unless there is some quick
way to mark that part of code "undebuggable", I'll better
leave that for the debugger maintainers to think about.

