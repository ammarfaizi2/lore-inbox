Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbTIYPYQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 11:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbTIYPYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 11:24:16 -0400
Received: from [195.120.246.30] ([195.120.246.30]:33676 "EHLO
	fatbastard.bmind.it") by vger.kernel.org with ESMTP id S261313AbTIYPYM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 11:24:12 -0400
Message-ID: <3F730899.7080700@bmind.it>
Date: Thu, 25 Sep 2003 17:24:09 +0200
From: Paolo Dovera <pdovera@bmind.it>
Organization: bmind SpA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: it, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: kakadu_croc@yahoo.com
Subject: Re: 2.6.0-test broke RPM 4.2 on Red Hat 9 in a VERY weird way
References: <20030925132630.59015.qmail@web40903.mail.yahoo.com>
In-Reply-To: <20030925132630.59015.qmail@web40903.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, try this:

export LD_ASSUME_KERNEL=2.4.1

before run rpm command, this works fine on my RH9

        Paolo

Bradley Chapman wrote:

>I've just discovered a very strange and unusual problem with rpm on my Red Hat 9
>laptop running 2.6.0-test. Under 2.4.22-ac2 rpm runs perfectly fine, but when I
>run it under 2.6.0-test, it outputs the following errors:
>
>sudo rpm -Uvh alsa-driver-0.9.6-1.fr.i386.rpm
>Password:
>rpmdb: unable to join the environment
>error: db4 error(11) from dbenv->open: Resource temporarily unavailable
>error: cannot open Packages index using db3 - Resource temporarily unavailable (11)
>error: cannot open Packages database in /var/lib/rpm
>warning: alsa-driver-0.9.6-1.fr.i386.rpm: V3 DSA signature: NOKEY, key ID e42d547b
>rpmdb: unable to join the environment
>error: db4 error(11) from dbenv->open: Resource temporarily unavailable
>error: cannot open Packages database in /var/lib/rpm
>rpmdb: unable to join the environment
>error: db4 error(11) from dbenv->open: Resource temporarily unavailable
>error: cannot open Packages database in /var/lib/rpm
>
>I have never seen rpm do this before, and it only occurs under 2.6.0-test. It
>happens under these specific kernels:
>
>2.6.0-test5-bk10
>2.6.0-test5-bk11
>2.6.0-test5-mm4
>
>I have not tried -test5-bk12 yet, but I have a feeling that I will get the same
>errors. I have checked syslog and dmesg and there are no errors from the kernel;
>under 2.4.22-ac2 rpm works perfectly fine, so I don't believe it's file corruption
>or filesystem breakage.
>
>Does anyone have any ideas that I can try?
>
>Thanks!
>
>Brad
>
>
>
>=====
>Brad Chapman
>
>Permanent e-mail: kakadu_croc@yahoo.com
>
>__________________________________
>Do you Yahoo!?
>The New Yahoo! Shopping - with improved product search
>http://shopping.yahoo.com
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

