Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267553AbUJRVeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267553AbUJRVeZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 17:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267543AbUJRVeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 17:34:24 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:21441 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267720AbUJRVaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 17:30:06 -0400
Subject: Re: [PATCH] add unschedule_delayed_work to the workqueue API
From: James Bottomley <James.Bottomley@SteelEye.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       mingo@elte.hu
In-Reply-To: <1098134824.2011.322.camel@mulgrave>
References: <1098117067.2011.64.camel@mulgrave> 
	<20041018142524.5b81a09a.akpm@osdl.org> 
	<1098134824.2011.322.camel@mulgrave>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Oct 2004 16:29:48 -0500
Message-Id: <1098134994.2792.325.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-18 at 16:26, James Bottomley wrote:
> On Mon, 2004-10-18 at 16:25, Andrew Morton wrote:
> > The usual way of doing this is:
> > 
> > 	cancel_delayed_work(...);

OK, found it in the headers, sorry .. it's not synchronous, so it can't
really be used in most of the cases where we use del_timer_sync().

James


