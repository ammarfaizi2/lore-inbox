Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUL0BZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUL0BZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 20:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUL0BZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 20:25:56 -0500
Received: from hermes.domdv.de ([193.102.202.1]:34065 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261605AbUL0BZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 20:25:52 -0500
Message-ID: <41CF649E.20409@domdv.de>
Date: Mon, 27 Dec 2004 02:25:50 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-ac1
References: <1104103881.16545.2.camel@localhost.localdomain> <58cb370e04122616577e1bd33@mail.gmail.com>
In-Reply-To: <58cb370e04122616577e1bd33@mail.gmail.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> What do you need 'serialize' option for?

I didn't check if the problem is gone with 2.6.10 but there's boards 
like my tyan 2885 which do need the serialize option to work properly 
for add-on ide controllers.

 From the X86-64 patch release notes of Andi Kleen:

Reports that dual Tyan S2885 and S2880 can lock up when multiple IDE 
channels are stressed in parallel. "noapic" or "ideX=serialize" seems to 
work around it. Andre Hedrick thinks it's a generic bug/race in the IDE 
code.

Do you want to force people to disable the io-apic just because of 
option removal? In my case the serialized devices are a disk and a 
dvd-rw which is rarely used, so disabling the io-apic is a bad solution.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
