Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbVKYT6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbVKYT6N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 14:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbVKYT6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 14:58:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40361 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751472AbVKYT6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 14:58:12 -0500
Date: Fri, 25 Nov 2005 11:57:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: guillaume.thouvenin@bull.net, linux-kernel@vger.kernel.org,
       matthltc@us.ibm.com
Cc: Paul Jackson <pj@sgi.com>
Subject: Re: [BUG linux-2.6.15-rc] process events connector - soft lockup
 detected
Message-Id: <20051125115725.3ff23590.akpm@osdl.org>
In-Reply-To: <20051125114741.6549ef3a.akpm@osdl.org>
References: <20051125144226.37778246@frecb000711.frec.bull.fr>
	<20051125114741.6549ef3a.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
>  Gad, how ddd that get in there?

That's how to pronounce "did" with a headcold.

I note that copy_process() also calls cpuset_fork() under
write_lock_irq(&tasklist_lock) which is a) inefficient and b) forbidden
according to the nice comment over task_lock().
