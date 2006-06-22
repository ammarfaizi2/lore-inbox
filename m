Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932760AbWFVEBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbWFVEBW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 00:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWFVEBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 00:01:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20417 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751292AbWFVEBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 00:01:21 -0400
Date: Wed, 21 Jun 2006 21:01:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org, kevcorry@us.ibm.com
Subject: Re: [PATCH 06/15] dm mirror log: refactor context
Message-Id: <20060621210110.c53b716f.akpm@osdl.org>
In-Reply-To: <20060621193458.GU4521@agk.surrey.redhat.com>
References: <20060621193458.GU4521@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 20:34:58 +0100
Alasdair G Kergon <agk@redhat.com> wrote:

> +static void core_dtr(struct dirty_log *log)
> +{
> +	struct log_c *lc = (struct log_c *) log->context;

dirty_log.context is void*, so the cast is unneeded (multiple places).
