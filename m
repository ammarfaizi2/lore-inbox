Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWDKGWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWDKGWQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 02:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWDKGWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 02:22:16 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:32185 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932229AbWDKGWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 02:22:15 -0400
Date: Tue, 11 Apr 2006 14:19:23 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] de_thread: Don't confuse users do_each_thread.
Message-ID: <20060411101923.GB112@oleg>
References: <20060406220403.GA205@oleg> <m1y7yddo75.fsf_-_@ebiederm.dsl.xmission.com> <m1u091dnry.fsf@ebiederm.dsl.xmission.com> <200604110152.38861.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604110152.38861.ioe-lkml@rameria.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11, Ingo Oeser wrote:
>
> While you are at it: Could you please avoid calculating current over 
> and over again? 
> 
> Just calculate it once and use the task_struct pointer.

Ironically, de_thread() has 'tsk' parameter which is equal to 'current'.

Oleg.

