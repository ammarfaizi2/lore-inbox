Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269563AbUJLJfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269563AbUJLJfr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 05:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269578AbUJLJfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 05:35:47 -0400
Received: from mail.renesas.com ([202.234.163.13]:17536 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S269563AbUJLJfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 05:35:22 -0400
Date: Tue, 12 Oct 2004 18:35:07 +0900 (JST)
Message-Id: <20041012.183507.350531171.takata.hirokazu@renesas.com>
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org, akpm@osdl.org
Subject: Re: [PATCH 2.6.9-rc3-mm2] [m32r] SIO driver for m32r
From: Hirokazu Takata <takata.hirokazu@renesas.com>
In-Reply-To: <E1CF6W4-0001hS-00@calista.eckenfels.6bone.ka-ip.net>
References: <20041006.151912.840807084.takata.hirokazu@renesas.com>
	<E1CF6W4-0001hS-00@calista.eckenfels.6bone.ka-ip.net>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Bernd,

From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
Subject: Re: [PATCH 2.6.9-rc3-mm2] [m32r] SIO driver for m32r
Date: Wed, 06 Oct 2004 09:47:16 +0200
> In article <20041006.151912.840807084.takata.hirokazu@renesas.com> you wrote:
> > +static void sio_error(int *status)
> > +{
> > +       printk("SIO0 error[%04x]\n", *status);
> > +       do {
> > +               sio_init();
> > +       } while ((*status = __sio_in(PLD_ESIO0CR)) != 3);
> > +}
> 
> is this safe and sane? Wont that lockup the machine on hardware problems? 

Hmm..  Do you have any good idea to fix it?

> It
> is also duplicated, with only the port differ.

OK.  I will try to merge them.

> Greetings
> Bernd
> -- 
> eckes privat - http://www.eckes.org/
> Project Freefire - http://www.freefire.org/

Thanks.

-- Takata
