Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVA1Onr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVA1Onr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 09:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVA1Onr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 09:43:47 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:23227 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261423AbVA1Onp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 09:43:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=UfqGjFL9d2yTL8+uP5yBEY4upGaTqmw9HyjSN0GMvYkEiKptAhzTQAd22xgjkUwcAAR2sMku7wkuFKiIgpgZvmKrBoqCRaumHdb0Bx1A39wqT8lTEve7QP3fyQfVkTx+Y2MOiN/S7JntEb/96oIiXiogvhwBaqJW5GTAuHQsmDc=
Message-ID: <d120d50005012806435a17fe98@mail.gmail.com>
Date: Fri, 28 Jan 2005 09:43:45 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Olaf Hering <olh@suse.de>
Subject: Re: atkbd_init lockup with 2.6.11-rc1
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
In-Reply-To: <20050128135827.GA28784@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050128132202.GA27323@suse.de> <20050128135827.GA28784@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005 14:58:27 +0100, Olaf Hering <olh@suse.de> wrote:
> On Fri, Jan 28, Olaf Hering wrote:
> 
> >
> > My IBM RS/6000 B50 locks up with 2.6.11rc1, it dies in atkbd_init():
> 
> It fails also on PReP, not only on CHRP. 2.6.10 looks like this:
> 
> Calling initcall 0xc03bc430: atkbd_init+0x0/0x2c()
> atkbd.c: keyboard reset failed on isa0060/serio1
> atkbd.c: keyboard reset failed on isa0060/serio0
>

So it could not reset it even before, but it was not getting stuch
tough... What about passing atkbd.reset=0?
-- 
Dmitry
