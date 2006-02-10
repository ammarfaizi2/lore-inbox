Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWBJMqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWBJMqb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWBJMqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:46:31 -0500
Received: from mail.dvmed.net ([216.237.124.58]:44992 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751252AbWBJMq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:46:29 -0500
Message-ID: <43EC8B1E.8050207@pobox.com>
Date: Fri, 10 Feb 2006 07:46:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Philippe Seewer <philippe.seewer@bfh.ch>
CC: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: libata janitor project
References: <43EC7EFB.5020100@pobox.com> <loom.20060210T132349-817@post.gmane.org>
In-Reply-To: <loom.20060210T132349-817@post.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Philippe Seewer wrote: > Jeff Garzik <jgarzik <at>
	pobox.com> writes: (please don't cut CC's, particularly linux-ide)
	>>Long term, we should work to replace the assert() in libata with
	>>standard kernel WARN_ON(). >> >>If someone wanted to handle that
	conversion, that would be useful. Make >>sure to pay attention, the
	sense of each test must be reversed. >> >> Jeff >> >>- >>To unsubscribe
	from this list: send the line "unsubscribe linux-ide" in >>the body of
	a message to majordomo <at> vger.kernel.org >>More majordomo info at
	http://vger.kernel.org/majordomo-info.html >> >> > > > Just so stupid
	little me understands this: > replace for example: > assert(sg != NULL)
	> with > WARN_ON(sg == NULL) > > right? [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Seewer wrote:
> Jeff Garzik <jgarzik <at> pobox.com> writes:

(please don't cut CC's, particularly linux-ide)


>>Long term, we should work to replace the assert() in libata with 
>>standard kernel WARN_ON().
>>
>>If someone wanted to handle that conversion, that would be useful.  Make 
>>sure to pay attention, the sense of each test must be reversed.
>>
>>	Jeff
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>>the body of a message to majordomo <at> vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> 
> 
> Just so stupid little me understands this:
> replace for example: 
>   assert(sg != NULL)
> with
>   WARN_ON(sg == NULL)
> 
> right? 

Correct.


> ...What about WARN_ON being defined bu HAVE_ARCH_BUG_ON and assert by ATA_DEBUG?

I would rather just unconditionally use WARN_ON(), and eliminate assert().

	Jeff


