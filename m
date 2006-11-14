Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966213AbWKNRGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966213AbWKNRGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 12:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966214AbWKNRGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 12:06:20 -0500
Received: from elvis.mu.org ([192.203.228.196]:11249 "EHLO elvis.mu.org")
	by vger.kernel.org with ESMTP id S966213AbWKNRGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 12:06:19 -0500
Message-ID: <4559F781.6020607@FreeBSD.org>
Date: Tue, 14 Nov 2006 09:06:09 -0800
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shem Multinymous <multinymous@gmail.com>
CC: Andi Kleen <ak@suse.de>, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz, Jiri Bohac <jbohac@suse.cz>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 0/2] Make the TSC safe to be used by gettimeofday().
References: <455916A5.2030402@FreeBSD.org> <200611140250.57160.ak@suse.de>	 <45592497.1080109@FreeBSD.org> <41840b750611140430k3b46023dr9a01b8b38bbb535d@mail.gmail.com>
In-Reply-To: <41840b750611140430k3b46023dr9a01b8b38bbb535d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shem Multinymous wrote:
> On 11/14/06, Suleiman Souhlal <ssouhlal@freebsd.org> wrote:
> 
>> I believe that the results returned will always be monotonic, as long as
>> the frequency of the TSC does not change from under us (that is, without
>> the kernel knowing). This is because we "synchronize" each CPU's vxtime
>> with a global time source (HPET) every time we know the TSC rate changes.
> 
> 
> Does this hold after a suspend/resume cycle? You could be resuming
> with a different CPU clock than what you suspended with, and I'm not
> sure anything guarantees an early enough re-sync.

I have to admit that I didn't really design this patch with 
suspend/resume in mind, and that I'm not too familiar with how they work.

Do the HPET/ACPI timers still run while the system is suspended?
If not, there shouldn't be any problem, as long as the kernel is 
informed of the resume early enough.

-- Suleiman
