Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264431AbTIIT5Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbTIIT5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:57:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44248 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264431AbTIIT5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:57:16 -0400
Date: Tue, 9 Sep 2003 12:46:35 -0700
From: "David S. Miller" <davem@redhat.com>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Missing memory barrier on net/core/dev.c
Message-Id: <20030909124635.3c0d522b.davem@redhat.com>
In-Reply-To: <3F5E14D7.9030809@terra.com.br>
References: <3F5E14D7.9030809@terra.com.br>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Sep 2003 14:58:47 -0300
Felipe W Damasio <felipewd@terra.com.br> wrote:

> 	I *think* net/core/dev.c is missing a mb() before calling 
> schedule_timoeut.

I have another patch in my queue from Andrew Morton that
removes the TASK_RUNNING setting altogether, schedule_timeout()
always returns with the task in that state.
