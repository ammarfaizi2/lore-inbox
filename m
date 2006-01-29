Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWA2Kst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWA2Kst (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 05:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWA2Kst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 05:48:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50571 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750906AbWA2Kst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 05:48:49 -0500
Date: Sun, 29 Jan 2006 02:48:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Only allow a threaded init to exec from the
 thread_group_leader
Message-Id: <20060129024831.4474142f.akpm@osdl.org>
In-Reply-To: <m1irs38h5v.fsf@ebiederm.dsl.xmission.com>
References: <m14q3nh7zi.fsf@ebiederm.dsl.xmission.com>
	<20060129003606.7887ecd9.akpm@osdl.org>
	<m1irs38h5v.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>  If process id namespaces become a reality init stops being
>  terribly special, and becomes something you may have several
>  of running at any one time.  If one of those inits is compromised
>  by a hostile user I having the whole system go down so we can
>  avoid executing a cheap test sounds terribly wrong.  That is
>  why I really care.

Wouldn't it be better to do nothing until/unless there's some code in the
kernel or init which actually needs the change?

