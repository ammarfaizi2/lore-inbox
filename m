Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317371AbSIEJhB>; Thu, 5 Sep 2002 05:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317365AbSIEJhB>; Thu, 5 Sep 2002 05:37:01 -0400
Received: from rj.SGI.COM ([192.82.208.96]:48572 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317363AbSIEJhA>;
	Thu, 5 Sep 2002 05:37:00 -0400
Date: Thu, 5 Sep 2002 02:39:41 -0700 (PDT)
From: Jeremy Higdon <jeremy@classic.engr.sgi.com>
Message-Id: <10209050239.ZM52086@classic.engr.sgi.com>
In-Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
        "Re: aic7xxx sets CDR offline, how to reset?" (Sep  4, 10:50am)
References: <200209041613.g84GDtv02639@localhost.localdomain> 
	<12750000.1031158209@aslan.btc.adaptec.com>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 4, 10:50am, Justin T. Gibbs wrote:
> 
>    This of course assumes that all transactions have a serial number and
>    that requeuing transactions orders them by serial number.  With QErr
>    set, the device closes the rest if the barrier race for you, but even
>    without barriers, full transaction ordering is required if you don't
>    want a read to inadvertantly pass a write to the same location during
>    recovery.


The original FCP (SCSI commands over Fibre) profile specified that QERR=1
was not available.  Unless that is changed, it would appear that you cannot
count on being able to set Qerr.

Qerr was one of those annoying little things in SCSI that forces host
adapter drivers to know a mode page setting.

jeremy
