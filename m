Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264990AbTFQWhH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbTFQWhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:37:06 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:1641 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264990AbTFQWhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:37:05 -0400
Date: Tue, 17 Jun 2003 15:51:43 -0700
From: Andrew Morton <akpm@digeo.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI device list locking
Message-Id: <20030617155143.6d3a2e95.akpm@digeo.com>
In-Reply-To: <20030617212628.GA12723@kroah.com>
References: <20030617212628.GA12723@kroah.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jun 2003 22:51:00.0506 (UTC) FILETIME=[EC3C97A0:01C33522]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> +		spin_lock(&pci_bus_lock);
>  

I have a vague feeling that some code somewhere may be calling these
functions from interrupt context.

I may have misremembered, but perhaps a sprinkling of
WARN_ON(irqs_disabled()) would be prudent for now.

