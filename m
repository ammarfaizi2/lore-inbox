Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265293AbTF1RGM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 13:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265297AbTF1RGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 13:06:12 -0400
Received: from air-2.osdl.org ([65.172.181.6]:16851 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265293AbTF1RGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 13:06:09 -0400
Message-ID: <33004.4.4.25.4.1056820826.squirrel@www.osdl.org>
Date: Sat, 28 Jun 2003 10:20:26 -0700 (PDT)
Subject: Re: 2.5.73-mm1 nbd: boot hang in add_disk at first call from nbd_init
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <mflt1@micrologica.com.hk>
In-Reply-To: <200306281346.53609.mflt1@micrologica.com.hk>
References: <200306271943.13297.mflt1@micrologica.com.hk>
        <20030627194154.01a06c5d.akpm@digeo.com>
        <200306281255.36048.mflt1@micrologica.com.hk>
        <200306281346.53609.mflt1@micrologica.com.hk>
X-Priority: 3
Importance: Normal
Cc: <akpm@digeo.com>, <ldl@aros.net>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Saturday 28 June 2003 12:55, Michael Frank wrote:
>> On Saturday 28 June 2003 10:41, Andrew Morton wrote:
>> > Michael Frank <mflt1@micrologica.com.hk> wrote:
>> > > Changes were recently made to the nbd.c in 2.5.73-mm1
>> >
>> > And tons more will be in -mm2, which I shall prepare right now. Please
>> retest on that and if it still hangs, capture the output from pressing
>> alt-sysrq-T.
>>
>> Legacy free, no serial port.
>>
>>
>>
>> Sorry, -mm2 hang at booting kernel on 2 machines.
>>
>
> Oh Murphy! Bug: 250K log buffer causes a hang on boot.
>
> Sorry for the shock. I configured the log buffer bigger - 250K and it hangs
> on boot.
>
> Default 14K log buffer all OK, the NBD hang is fixed too.

Default value of 14 is a shift count (2 << 14), which gives a
16 KB buffer.
Did you enter '250' for the shift value?
Yes, that wouldn't boot.
Maybe consult the help text??

> This was my only config change besides that driver which didn't compile ;)
>
> I want a bigger log buffer in preparation for testing swsusp on 2.5. On 2.4,
>  the test io load prevent the big swsusp logs from making it to disk...

Andrew, do you want a min/max limit on the LOG_BUF_SHIFT value,
now that Roman has added that feature for Kconfig?

~Randy



