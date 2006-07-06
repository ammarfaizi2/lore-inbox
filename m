Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbWGFAy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbWGFAy7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 20:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbWGFAy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 20:54:59 -0400
Received: from terminus.zytor.com ([192.83.249.54]:13716 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965103AbWGFAy7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 20:54:59 -0400
Message-ID: <44AC5F5C.7070907@zytor.com>
Date: Wed, 05 Jul 2006 17:54:52 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nigel Cunningham <ncunningham@linuxmail.org>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: Re: [klibc 30/31] Remove in-kernel resume-from-disk invocation code
References: <klibc.200606272217.00@tazenda.hos.anvin.org> <200607060940.40678.ncunningham@linuxmail.org> <44AC551B.8090204@zytor.com> <200607061037.11177.ncunningham@linuxmail.org>
In-Reply-To: <200607061037.11177.ncunningham@linuxmail.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> 
> Ah. So it's still valid to have resume= and noresume on the commandline, and 
> klibc greps /proc/cmdline?
> 

Correct.

> So, for Suspend2, would I be ok just leaving people to add the echo 
>>/proc/suspend2/do_resume, as we currently do for initrds and initramfses?

Well, presumably you want to adjust kinit so that it invokes 
/proc/suspend2/do_resume, instead of or in addition to 
/sys/power/resume; see usr/kinit/resume.c (the code should be bloody 
obvious, I hope...)

	-hpa
