Return-Path: <linux-kernel-owner+w=401wt.eu-S1752963AbWLTKMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963AbWLTKMb (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 05:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753539AbWLTKMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 05:12:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:37232 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963AbWLTKMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 05:12:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=d2Fo1jIkp484VqsPxMAfVugavsszc09cpTnaDcYiBSx7pXVm54hkZ0BhRZOw2bFyqxhTekLj7MtDNPdCPP5OqBA3tgSEJPtfIu2d81bQGsYJIMPRQ1YkupXdFHS2WW6a4BFaFuDHSqrGEnUs8jeH9I+lSSdBmqMDPPppv0mWzI4=
Message-ID: <86802c440612200212g219e395apd0b2266aa4091e3b@mail.gmail.com>
Date: Wed, 20 Dec 2006 02:12:29 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Cc: "ard@telegraafnet.nl" <ard@telegraafnet.nl>, take@libero.it,
       agalanin@mera.ru, linux-kernel@vger.kernel.org,
       bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Zhang Yanmin" <yanmin.zhang@intel.com>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <200612200502_MC3-1-D5AF-1674@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612200502_MC3-1-D5AF-1674@compuserve.com>
X-Google-Sender-Auth: a06263e30766dd93
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/06, Chuck Ebbert <76306.1226@compuserve.com> wrote:
> But it seems interrupts are on--look at the flags:
>
>         RSP: 0018:ffffffff803cdf68  EFLAGS: 00010246

Yes, the IF bit is set.

maybe someone (reporters) could add !irq_disabled() and printk in
start_kernel init/main.c to see which function cause the irq get
enabled.

YH
