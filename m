Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWGCXuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWGCXuQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 19:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWGCXuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 19:50:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:29241 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932292AbWGCXuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 19:50:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=PyNIKGW9gM82jlcBbKQUXQcGUDm157GxRV7mUnTM8nrNDG+cBz04yxGmcyeqxrDXOehjR7E8EJiV7o9f364wJvPN+n0C7vfRHzArTvfoaj36EHfmRRUWEKNR84cU+PCzP1hMBcCt5Ul8vusDNkA5HLB+IZl9h+46PLCC3sE/iVA=
Message-ID: <44A9AD48.5020400@gmail.com>
Date: Tue, 04 Jul 2006 01:50:09 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org
Subject: Re: swsusp regression
References: <44A99DFB.50106@gmail.com>	<44A99FE5.6020806@gmail.com> <20060703161034.a5c4fba9.akpm@osdl.org>
In-Reply-To: <20060703161034.a5c4fba9.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton napsal(a):
> On Tue, 04 Jul 2006 00:53:02 +0159
> Jiri Slaby <jirislaby@gmail.com> wrote:
> 
>> Jiri Slaby napsal(a):
>>> Hello,
>>>
>>> when suspending machine with hyperthreading, only Freezing cpus appears and then
>> Note: suspending to disk; done by:
>> echo reboot > /sys/power/disk
>> echo disk > /sys/power/state
>>
>>> it loops somewhere. I tried to catch some more info by pressing sysrq-p. Here
>>> are some captures:
>>> http://www.fi.muni.cz/~xslaby/sklad/03072006074.gif
>>> http://www.fi.muni.cz/~xslaby/sklad/03072006075.gif
>> One more from some previous kernels (cutted sysrq-t):
>> http://www.fi.muni.cz/~xslaby/sklad/22062006046.jpg
>>
> 
> If you replace kernel/stop_machine.c with the version from 2.6.17, does it
> help?

Yup. It seems so.

regards,
-- 
Jiri Slaby        www.fi.muni.cz/~xslaby/
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
