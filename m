Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWFBNOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWFBNOW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 09:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWFBNOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 09:14:22 -0400
Received: from wx-out-0102.google.com ([66.249.82.196]:26694 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750760AbWFBNOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 09:14:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=QxvdE87U5gangRFw+DiLhBacq+VWBf6coAcDSpjpWHmLBaM9msk12ZCPg+d9+cDVVcrtpaCWg+MyKAx12cSZvuW0tmJXwWX7sSwhqCLXMapeuYRgGHd0DeJM2Z+IhR+O7hts9CXWjTqPvZ4phjcYuf6nauz2qpup+ih9y3Mtx18=
Message-ID: <986ed62e0606020614j363bd71bn7d1fba23b78571f3@mail.gmail.com>
Date: Fri, 2 Jun 2006 06:14:21 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm2
Cc: linux-kernel@vger.kernel.org, "Ingo Molnar" <mingo@elte.hu>,
       "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <20060601183836.d318950e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	 <986ed62e0606011758w348080ebn6e8430ec9e5b2ed3@mail.gmail.com>
	 <20060601183836.d318950e.akpm@osdl.org>
X-Google-Sender-Auth: a741c6c6fd6cf53c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Ingo, I got your e-mail too, and I will reply to it once I've
followed your instructions.)

On 6/1/06, Andrew Morton <akpm@osdl.org> wrote:
> Damn, sorry.  LLC is completely borked.  You should emphatically set
> CONFIG_LLC=n.

Just one problem with that...

config ATALK
        tristate "Appletalk protocol support"
        select LLC

This box runs netatalk for both file and print service, but I could
temporarily disable it for testing... Ok, the kernel's up and running
w/o CONFIG_LLC and CONFIG_ATALK now, and the warning still happened at
boot time, but it has stayed up for over an hour without keeling over
with a panic.

It looks like netatalk was fixed at some point so that it can do AFP
over TCP without the presence of a running atalkd, so unless I buy a
really old used Mac, I shouldn't need CONFIG_ATALK for the file server
anymore. Also, to make a *long* story short, I also should be able to
get rid of the print server in a few weeks. I'll still need to
occasionally boot back into a CONFIG_ATALK kernel to use the print
server until then, but I should be able to run an ATALK-less kernel
for days at a time (i.e. when the print server is not in use)...
-- 
-Barry K. Nathan <barryn@pobox.com>
