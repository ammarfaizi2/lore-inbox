Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbUEQWxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUEQWxi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 18:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUEQWxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 18:53:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:43194 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263019AbUEQWxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 18:53:33 -0400
Date: Mon, 17 May 2004 15:56:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init. mca_bus_type even if !MCA_bus
Message-Id: <20040517155607.313c4694.akpm@osdl.org>
In-Reply-To: <1084832306.2092.67.camel@mulgrave>
References: <20040517144603.1c63895f.rddunlap@osdl.org>
	<20040517151412.1f7fb7d4.akpm@osdl.org>
	<1084832306.2092.67.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> On Mon, 2004-05-17 at 17:14, Andrew Morton wrote:
> > Why is it appropriate to register the MCA bus type when there is no
> > MCA bus present?
> 
> The legacy bus functions all have a bus_for_each_dev in them.  This
> can't execute correctly unless the bus is registered.  So either a check
> for MCA_bus has to be added to each of them, or we register the bus but
> attach no devices, so the loop exits without doing anything.
> 

Fair enough.  Let's run with Randy's patch and see what else explodes ;)
