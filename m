Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbVLUJtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbVLUJtS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 04:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVLUJtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 04:49:17 -0500
Received: from jack.kinetikon.it ([62.152.125.81]:41368 "EHLO
	mail.towertech.it") by vger.kernel.org with ESMTP id S932347AbVLUJtR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 04:49:17 -0500
Date: Wed, 21 Dec 2005 10:50:01 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/6] RTC subsystem, class
Message-ID: <20051221105001.226178f1@inspiron>
In-Reply-To: <200512202101.39498.dtor_core@ameritech.net>
References: <20051220214511.12bbb69c@inspiron>
	<200512202101.39498.dtor_core@ameritech.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005 21:01:39 -0500
Dmitry Torokhov <dtor_core@ameritech.net> wrote:


> > +       if (ops->read_time) {
> > +               memset(tm, 0, sizeof(struct rtc_time));
> > 
> 
> What guarantees that ops is not NULL here? Userspace can keep the
> attribute (file) open and issue read after class_device was unregistered
> and devdata set to NULL.

 Right. For /proc and /dev there's a try_module_get(ops->owner) in place. 

 Should I add it to every rtc_sysfs_show_xxx or there's
 a better way to do it?

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

