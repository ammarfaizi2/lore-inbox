Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWHHGbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWHHGbI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 02:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWHHGbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 02:31:08 -0400
Received: from mail.gmx.de ([213.165.64.20]:34259 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751191AbWHHGbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 02:31:07 -0400
X-Authenticated: #14349625
Subject: Re: [BUG] futex_handle_fault always fails.
From: Mike Galbraith <efault@gmx.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       rusty@rustcorp.com.au, jakub@redhat.com
In-Reply-To: <1154986798.5343.26.camel@localhost.localdomain>
References: <1154986798.5343.26.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 08:38:32 +0000
Message-Id: <1155026312.7331.12.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-07 at 14:39 -0700, john stultz wrote:
> The following patch addresses these two issues by 1) Always setting ret
> to -EFAULT if futex_handle_fault fails, and 2) Removing the = in
> futex_handle_fault's (attempt >= 2) check.

Nit:  why not use the return value directly instead of translating that
return (-EFAULT) into -EFAULT?

	-Mike

