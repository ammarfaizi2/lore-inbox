Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbUKQH30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbUKQH30 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 02:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbUKQH30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 02:29:26 -0500
Received: from mail.broadpark.no ([217.13.4.2]:11912 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S262222AbUKQH3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 02:29:21 -0500
Message-ID: <419AFE1A.1090905@linux-user.net>
Date: Wed, 17 Nov 2004 08:30:34 +0100
From: Daniel Andersen <anddan@linux-user.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041020)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       linux-kernel@vger.kernel.org
Subject: Re: acpi_power_off issue in 2.6.10-rc2-mm1
References: <Pine.LNX.4.61.0411162301460.5829@student.dei.uc.pt> <20041116235009.GG8674@redhat.com>
In-Reply-To: <20041116235009.GG8674@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Tue, Nov 16, 2004 at 11:10:03PM +0000, Marcos D. Marado Torres wrote:
> 
>  > In 2.6.10-rc2 and previous kernels acpi_power_off allways worked fine, but 
>  > in
>  > 2.6.10-rc2-mm1 when I do 'halt' all runs fine, the last message 
>  > "acpi_power_off
>  > called. System is going to power off" (something like this, I don't recall
>  > ^-^;) appears, but then the machine just doesn't power off.
>  > 
>  > This is happening with an ASUS M3N laptop, I guess that it's a problem
>  > somewhere in
>  > http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm1/broken-out/bk-acpi.patch
>  > When I get some time I'll take a deeper look into it...
> 
> This one has been around for a while. It's been plagueing me since 2.6.8,
> though its interesting that you only see it happening recently.
> 
> My attempts to debug it led to the bug disappearing when I added
> instrumentation to the kernel.  On my Compaq Evo, it does power off
> eventually, though it takes about a minute after that last
> acpi_power_off message.
> 
> There are bugs open on this in bugme.osdl.org, and bugzilla.redhat.com
> 
> http://bugme.osdl.org/show_bug.cgi?id=3642
> https://bugzilla.redhat.com/beta2/show_bug.cgi?id=acpi_power_off
> 
> 		Dave
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I'm having the same problem with 2.6.10-rc2-mm1. I did not have the 
problem with 2.6.10-rc1-mm5 and earlier as I remember. Will look into it.

Daniel Andersen

-- 
