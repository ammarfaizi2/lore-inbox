Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271125AbTGPVlK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 17:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271134AbTGPVlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 17:41:10 -0400
Received: from mail.kroah.org ([65.200.24.183]:46821 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S271125AbTGPVlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 17:41:04 -0400
Date: Wed, 16 Jul 2003 14:36:07 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-ID: <20030716213607.GA2773@kroah.com>
References: <20030716184609.GA1913@kroah.com> <20030716130915.035a13ca.akpm@osdl.org> <20030716210253.GD2279@kroah.com> <20030716141320.5bd2a8b3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716141320.5bd2a8b3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 02:13:20PM -0700, Andrew Morton wrote:
> 
> The new dev_t encoding is a bit weird because we of course continue to
> support the old 8:8 encoding.  I think the rule is: "if the top 32-bits are
> zero, it is 8:8, otherwise 32:32".  We can express this nicely with
> "%u:%u".

Sounds good, much appreciated.

> Now I need to go hunt down all those places where I added casts to unsigned
> longs in printks.  hrm.

Heh, I think I got a few of them with my patch.  Who else prints out the
dev_t value?

thanks,

greg k-h
