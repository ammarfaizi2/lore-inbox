Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbULVEqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbULVEqp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 23:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbULVEqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 23:46:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18594 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261236AbULVEqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 23:46:37 -0500
Message-ID: <41C8FC25.2060304@pobox.com>
Date: Tue, 21 Dec 2004 23:46:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] USB: fix Scheduling while atomic warning when resuming.
References: <200412220103.iBM13wS0002158@hera.kernel.org> <41C8EE9A.9080707@pobox.com> <200412212022.52316.david-b@pacbell.net>
In-Reply-To: <200412212022.52316.david-b@pacbell.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> On Tuesday 21 December 2004 7:48 pm, Jeff Garzik wrote:
> 
>>If we are going for a minimalist -rc patch, why not drop the lock, 
>>sleep, then reacquire the lock?
> 
> 
> If that lock were dropped, what would prevent other tasks from
> touching the hardware while it's sending RESUME signaling down
> the bus, and thereby mucking up the resume sequence?

Precisely what other tasks are active for this hardware, during resume?

	Jeff



