Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVL0DPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVL0DPz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 22:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbVL0DPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 22:15:55 -0500
Received: from smtp6.libero.it ([193.70.192.59]:16360 "EHLO smtp6.libero.it")
	by vger.kernel.org with ESMTP id S932202AbVL0DPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 22:15:54 -0500
Date: Tue, 27 Dec 2005 04:16:52 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 1/6] RTC subsystem, class
Message-ID: <20051227041652.0c4e5685@inspiron>
In-Reply-To: <20051226201657.GA1974@elf.ucw.cz>
References: <20051220214511.12bbb69c@inspiron>
	<20051222133507.GA10208@elf.ucw.cz>
	<20051226034754.1fdfc393@inspiron>
	<20051226201657.GA1974@elf.ucw.cz>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Dec 2005 21:16:57 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> > > > +int rtc_set_alarm(struct class_device *class_dev, struct rtc_wkalrm*alrm)
> > > 
> > > Struct rtc_wake_alarm *alarm, those wovels are there for readability.
> > 
> >  I'm not the one who created this structure. It's defined
> >  in linux/rtc.h since a long time. I can only change alrm
> >  to alarm.
> 
> Sorry if you are not responsible... Yes, alarm would be better.
> 
> How does this relate to /proc/acpi/alarm, btw? Do they use same RTC
> alarm?

 Yes, they do. The ACPI subsystem does direct I/O on the cmos clock.

 Given the complexity of the ACPI code, when/if the x86 rtc driver
 will be ported to the RTC subsystem, it would be wise
 to disable the alarm part if ACPI is compiled in.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

