Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267943AbUJLWFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267943AbUJLWFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 18:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267936AbUJLWFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 18:05:44 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:30406 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267943AbUJLWFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 18:05:35 -0400
Subject: Re: [BUG]  oom killer not triggering in 2.6.9-rc3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <416B6594.5080002@nortelnetworks.com>
References: <41672D4A.4090200@nortelnetworks.com>
	 <1097503078.31290.23.camel@localhost.localdomain>
	 <416B6594.5080002@nortelnetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097614971.2639.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 12 Oct 2004 22:02:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-10-12 at 06:03, Chris Friesen wrote:
>  > Switch the machine to strict accounting
> > and it'll kill or block memory access correctly.
> 
> I must be able to run an app that uses over 90% of system memory, and calls 
> fork().  I was under the impression this made strict accounting unfeasable?

Its rather smarter than that, you'll want swap probably. The strict
accountant is a virtual address accountant not a memory accountant. It
knows shared r/o segments don't need charging all the time etc


