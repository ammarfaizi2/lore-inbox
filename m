Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWFAWQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWFAWQM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 18:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWFAWQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 18:16:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:43682 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750734AbWFAWQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 18:16:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=gv3qWTr5/IyhAGuOfRoFiSYXLaB/PnaWqoJtHrhOoKT2e7bJVLz1jtUkXodJ2LfZhAJT6nJ9fMSxcnfZTF0XjcGiWqOcsfvCC/wh5kWGUS1yNRFvRlUq8UzXMCGQNbnOUvM/gh7j8upc20y12P9zn42siTNvIUaevZs3bVAX1Cw=
Message-ID: <447F6725.9010806@gmail.com>
Date: Fri, 02 Jun 2006 01:16:05 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: input: fix comments and blank lines in new ff code
References: <20060530105705.157014000@gmail.com>	<20060530110131.136225000@gmail.com>	<20060530222122.069da389.rdunlap@xenotime.net>	<447F3AE4.6010206@gmail.com>	<20060601125256.de2897f4.rdunlap@xenotime.net>	<447F47FD.2050705@gmail.com>	<20060601130923.38f83fb6.rdunlap@xenotime.net>	<20060601204716.GA6847@delta.onse.fi> <20060601143356.f5b8d4f5.rdunlap@xenotime.net>
In-Reply-To: <20060601143356.f5b8d4f5.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Thu, 1 Jun 2006 23:47:16 +0300 Anssi Hannula wrote:
> 
> 
>>From: Anssi Hannula <anssi.hannula@gmail.com>
>>
>>Fix comments so that they conform to kernel-doc or remove ** if they are
>>not in kernel-doc format.
>>Akso add/remove some blank lines.
>>
>>Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>
>>---
>>
>>Note that the From header of my email is different as otherwise
>>osdl.org would mark my email as spam. Please use my gmail.com address.
> 
> 
> What's up with that?  OSDL filters are overly strong?
> 

If I send mail with non-google SMTP server using a gmail.com address in
>From field, the osdl.org server drops the email as spam. That's because
they've configured their server to promote gmail.com SPF record ?all to
-all (meaning that gmail.com SPF record says it neither denies or
allowes messages from other SMTPs to use the gmail.com as From address,
but osdl.org interpretes that as denial) due to high count of forged
gmail.com mails.

I've no problem with Thunderbird anymore as I configured it to use
gmail.com TLS SMTP server instead for emails where From is my gmail.com
address. However I can't send inline patches using Thunderbird, only
MIME attachments (they are in cleartext and have "Content-Disposition:
inline", however).

The patch was sent with another client to avoid using a MIME attachment,
but that client was configured for my ISP's SMTP server.

I don't really know if a MIME attachment or "wrong" From email address
is a bigger nuisance.

> 
>>Index: linux-2.6.17-rc4-git12/drivers/usb/input/hid-pidff.c
>>===================================================================
>>--- linux-2.6.17-rc4-git12.orig/drivers/usb/input/hid-pidff.c	2006-06-01 18:51:39.000000000 +0300
>>+++ linux-2.6.17-rc4-git12/drivers/usb/input/hid-pidff.c	2006-06-01 23:24:47.000000000 +0300
>>@@ -914,16 +925,17 @@ static int pidff_reports_ok(struct input
>> 	return 1;
>> }
>> 
>>-/**
>>- * Find a field with a specific usage within a report
>>- * @report: The report from where to find
>>- * @usage: The wanted usage
>>+/*
>>+ * pidff_find_logical_field - find a field with a specific logical usage
>>+ * @report: the report from where to find
>>+ * @usage: the wanted usage
>>  * @enforce_min: logical_minimum should be 1, otherwise return NULL
>>  */
> 
> 
> Comment does not match function name.

Hmh, I wonder how did I do that... I will send a one-liner patch for this.

> 
>> static struct hid_field *pidff_find_special_field(struct hid_report *report,
>> 						  int usage, int enforce_min)
>> {
>> 	int i;
>>+
>> 	for (i = 0; i < report->maxfield; i++) {
>> 		if (report->field[i]->logical == (HID_UP_PID | usage)
>> 		    && report->field[i]->report_count > 0) {
> 
> 
> 
> And I noticed one function name _input_ff_erase().
> That might be a namespace violation... anyone know the namespace
> rules?

Namespace violation? Never heard of that one.

> Otherwise all looks good to me.


-- 
Anssi Hannula

