Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933336AbWLAHIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933336AbWLAHIU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 02:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933385AbWLAHIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 02:08:20 -0500
Received: from smtp.osdl.org ([65.172.181.25]:27054 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933336AbWLAHIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 02:08:19 -0500
Date: Thu, 30 Nov 2006 23:08:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mauricio Lin <mauricio.lin@indt.org.br>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH 2.6.19] kobject: kobject_uevent() returns manageable
 value
Message-Id: <20061130230812.dad6b0b2.akpm@osdl.org>
In-Reply-To: <456F4607.3000300@indt.org.br>
References: <456F4607.3000300@indt.org.br>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 16:58:47 -0400
Mauricio Lin <mauricio.lin@indt.org.br> wrote:

> Since kobject_uevent() function does not return an integer value to
> indicate if its operation was completed with success or not, it is
> worth changing it in order to report a proper status (success or
> error) instead of returning void.
> 
> Keep kobject_uevent() returning the status as integer provide a easier
> way for detecting possible failure in the function. Using void
> returning style may take people to waste more time to figure out if
> the "send to" or "receive from" an event is a bug in the kernel or
> user space. Furthermore, the current way to detect where the error is
> taking place in the kobject_uevent() requires additional inclusion of
> printk() in each "if" condition that can lead to failure.

Admirable idea, but we have large changes pending against that code
and none of this patch applies.

A patch against Greg's driver tree, or against latest -mm would suit, thanks.
