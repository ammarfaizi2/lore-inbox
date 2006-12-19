Return-Path: <linux-kernel-owner+w=401wt.eu-S932906AbWLSTOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932906AbWLSTOm (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 14:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932904AbWLSTOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 14:14:42 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55860 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932896AbWLSTOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 14:14:42 -0500
Date: Tue, 19 Dec 2006 10:58:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Processes stuck on I/O (2.6.20-rc1+git)
Message-Id: <20061219105830.b7a286ea.akpm@osdl.org>
In-Reply-To: <1166553975.7834.19.camel@localhost.localdomain>
References: <1166553975.7834.19.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006 10:46:15 -0800
Dave Hansen <haveblue@us.ibm.com> wrote:

> I was copying some stuff off of a USB device this morning, and saw the
> process freeze.  It was unkillable, but I figured the USB device had
> died and done something funny.  A little bit later, I had a git process
> do the same thing, but it was confined to dealing with an actual
> attached disk.
> 
> The processes that hung were git-prune-packed and gtkpod.  You can see
> them in the sysrq-t output below.  My kernel is from a git pull, post
> 2.6.20-rc1:

git-prune-packed is running sys_sync(), so it's most likely stuck on the
USB device as well.

Send rude email to lunux-usb-devel, join queue ;)
