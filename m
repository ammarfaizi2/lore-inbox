Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbUKBNUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbUKBNUl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 08:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbUKBMoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 07:44:20 -0500
Received: from mx1.elte.hu ([157.181.1.137]:62443 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261219AbUKBMmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:42:38 -0500
Date: Tue, 2 Nov 2004 13:42:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] add requeue task
Message-ID: <20041102124252.GE15290@elte.hu>
References: <418707E5.90705@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418707E5.90705@kolivas.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> add requeue task

ack for this bit, but please split this one out:

| Change the granularity code to requeue tasks at their best priority
| instead of changing priority while they're running. This keeps tasks 
| at their top interactive level during their whole timeslice.

this is a behavioral change and should go into the 'possible negative
effect on interactivity' bucket. (of course it could very likely have a
positive effect as well - the bucket is just to separate the risks.)

	Ingo

