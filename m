Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265314AbUFZAFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265314AbUFZAFL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 20:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265537AbUFZAFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 20:05:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:24809 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265314AbUFZAFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 20:05:08 -0400
Date: Fri, 25 Jun 2004 17:07:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Maurides <stud1313@di.uoa.gr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.x signal handler bug
Message-Id: <20040625170751.2acb3a67.akpm@osdl.org>
In-Reply-To: <40DCBBC3.2010308@di.uoa.gr>
References: <40DCBBC3.2010308@di.uoa.gr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Maurides <stud1313@di.uoa.gr> wrote:
>
> void catcher(int sig){
>     signal(SIGSEGV,catcher);
>     printf("requested: %9d malloced: %9d\n",len,real);
>     longjmp(env, 1);
> }

Use siglongjmp()
