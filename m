Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932691AbVLRIgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbVLRIgg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 03:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbVLRIgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 03:36:36 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:62065 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932691AbVLRIgf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 03:36:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JmoPdNx0gDwb7bb5BNJzF5Am9U6B6zoqQI3JZbD6wgn1bvlUXCXzNsTU14uAZKhblpY3wLIlX1XKzeS+0mJfzNU8g5I6Z/qw6c9DfKWsrUs/UawiJH4VtGVXa7DP1RKmHmD/trie/mZUFwtO7ITp17YzHU6nCro0hVwcoJRU/CU=
Message-ID: <f0309ff0512180036q179b9f12n16609f86743c1b9c@mail.gmail.com>
Date: Sun, 18 Dec 2005 00:36:34 -0800
From: Nauman Tahir <nauman.tahir@gmail.com>
To: Hua Feijun <hua.feijun@gmail.com>
Subject: Re: stop threads failed!
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3fe1d240512170057h2a1e0929o@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3fe1d240512170057h2a1e0929o@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/05, Hua Feijun <hua.feijun@gmail.com> wrote:
> I want to set threads's status to TASK_STOPPED by the following
> code.The syslog has show this rourine has been executed,buf the thread
> is still running.Who can tell me the reason?Thanks very much!
> write_lock(&tasklist_lock);
> do
> {
> printk("set threads stopped\n");
> p->state = TASK_STOPPED;
> } while ((p = next_thread(p)) != leader);
> write_unlock(&tasklist_lock);
> schedule();
> -

Have you specified the state TASK_INTERRUPTIBLE when you wake up the
thread? If not then do it to ba able to stop it later.
Anybody else correct me if I am wrong please
Regards
Nauman



> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
