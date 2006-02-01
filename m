Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161070AbWBAOyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161070AbWBAOyh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 09:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161068AbWBAOyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 09:54:37 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:52866 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1161070AbWBAOyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 09:54:37 -0500
Date: Wed, 1 Feb 2006 15:54:22 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Greg KH <greg@kroah.com>
cc: Aritz Bastida <aritzbastida@gmail.com>,
       Antonio Vargas <windenntw@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Right way to configure a driver? (sysfs, ioctl, proc, configfs,....)
In-Reply-To: <20060130213908.GA26463@kroah.com>
Message-ID: <Pine.LNX.4.61.0602011553410.22529@yvahk01.tjqt.qr>
References: <7d40d7190601261206wdb22ccck@mail.gmail.com> <20060127050109.GA23063@kroah.com>
 <7d40d7190601270230u850604av@mail.gmail.com>
 <69304d110601270834q5fa8a078m63a7168aa7e288d1@mail.gmail.com>
 <7d40d7190601300323t1aca119ci@mail.gmail.com> <20060130213908.GA26463@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> I guess I could pass three values on the same file, like this:
>> $ echo "5  1000  500" > meminfo
>> 
>> I know that breaks the sysfs golden-rule, but how can I pass those
>> values _atomically_ then? Having three different files wouldn't be
>> atomic...
>
>That's what configfs was created for.  I suggest using that for things
>like this, as sysfs is not intended for it.
>
Can't we just somewhat merge all the duplicated functionality between procfs,
sysfs and configfs...


Jan Engelhardt
-- 
