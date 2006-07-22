Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWGVFSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWGVFSD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 01:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWGVFSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 01:18:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23707 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932072AbWGVFSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 01:18:02 -0400
Date: Fri, 21 Jul 2006 22:17:45 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Sergej Pupykin <ps@lx-ltd.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB: count of reading urbs
Message-Id: <20060721221745.62349077.zaitcev@redhat.com>
In-Reply-To: <mailman.1153399921.28044.linux-kernel2news@redhat.com>
References: <mailman.1153399921.28044.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jul 2006 16:43:23 +0400, Sergej Pupykin <ps@lx-ltd.ru> wrote:

> Please, tell me. If I submit one urb, can I lost data? (If data comes when
> urb callback executed)

USB by its nature requires devices to have some buffering, because
polling by the host may be irregular or not often enough. So, usually
there is no loss of data in such case. If you delay resubmissions
enough to overrun device's internal queue, it may happen.

-- Pete
