Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWJJOcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWJJOcw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 10:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWJJOcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 10:32:51 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:54975 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932127AbWJJOcu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 10:32:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ebwjhoKA9FdpQA1KLwEXKNKUwnLHpnknmcn+u6uhk5dyqksBQx8uL48KHz7FuEMVVYgvcWH42k+5oElkzPWaeEs3rJ/d+VffQ+akUcL2gLBAM9vyrVoI8ub5C/4427xY6DFgioLtGpEDeYJP7C7GLAslHUaOa7n+FY5nfoQc3j0=
From: Yu Luming <luming.yu@gmail.com>
Organization: gmail
To: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Tue, 10 Oct 2006 22:32:46 +0800
User-Agent: KMail/1.8.2
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net,
       ismail@pardus.org.tr
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061005103657.GA4474@ucw.cz> <20061006211751.GA31887@lists.us.dell.com>
In-Reply-To: <20061006211751.GA31887@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200610102232.46627.luming.yu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Please move it into the kernel where it belongs, and use lcd
> > brightness subsystem like everyone else.
>
> We've been through this before.
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114067198323596&w=2
>
> In addition, the SMI call used to change the backlight level *may*
> require (if configured by the sysadmin in BIOS), a password be
> entered.
>
> This begs for a common userspace app that can grok libsmbios and
> kernel interfaces both, and use the appropriate method on each, rather
> than just putting it all in the kernel

>From my understanding, a cute userspace App shouldn't have this kind
of logic:
	if (is  DELL )
		invoke libsmbios
	if (is  foo)
		invoke libfoo,
	if (is bar)
		invoke libbar,
	....
	else
		operate on /sys/class/backlight/ ,.,..

It should be:
	just write/read  file in  /sys/class/backlight ,....

Right?

Thanks,
Luming



