Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271104AbTGPVb2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 17:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271120AbTGPVb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 17:31:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:19088 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271104AbTGPVb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 17:31:27 -0400
Date: Wed, 16 Jul 2003 14:39:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-Id: <20030716143902.4b26be70.akpm@osdl.org>
In-Reply-To: <20030716213451.GA1964@win.tue.nl>
References: <20030716184609.GA1913@kroah.com>
	<20030716130915.035a13ca.akpm@osdl.org>
	<20030716210253.GD2279@kroah.com>
	<20030716141320.5bd2a8b3.akpm@osdl.org>
	<20030716213451.GA1964@win.tue.nl>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> wrote:
>
> On Wed, Jul 16, 2003 at 02:13:20PM -0700, Andrew Morton wrote:
> 
> > The new dev_t encoding is a bit weird because we of course continue to
> > support the old 8:8 encoding.  I think the rule is: "if the top 32-bits are
> > zero, it is 8:8, otherwise 32:32".  We can express this nicely with
> > "%u:%u".
> 
> 16-bit only: 8:8, otherwise 32-bit only: 16:16, otherwise 32:32.
> 

Why do we need the 16:16 option?
