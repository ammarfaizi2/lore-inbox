Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265164AbUANIzQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 03:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265150AbUANIzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 03:55:16 -0500
Received: from mx2.elte.hu ([157.181.151.9]:24705 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265164AbUANIzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 03:55:12 -0500
Date: Wed, 14 Jan 2004 09:55:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Joe Korty <joe.korty@ccur.com>
Cc: rml@ximian.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] rq->curr==p not equivalent to task_running(rq,p)
Message-ID: <20040114085557.GA16818@elte.hu>
References: <20040113230220.GA13341@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113230220.GA13341@tsunami.ccur.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin 2.60
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Joe Korty <joe.korty@ccur.com> wrote:

> task_running(rq,p) is equivalent to (rq->curr == p) only for some
> architectures.  Boot tested on i386.

> -		if (rq->curr == p) {
> +		if (task_running(rq, p)) {

indeed - good catch. Andrew, please apply.

	Ingo
