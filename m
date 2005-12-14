Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVLNItb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVLNItb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 03:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVLNItb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 03:49:31 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:12004 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932152AbVLNIta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 03:49:30 -0500
Message-ID: <439FDCB0.7030705@jp.fujitsu.com>
Date: Wed, 14 Dec 2005 17:49:52 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Dave Jones <davej@redhat.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add mem_nmi_panic enable system to panic on hard error
References: <439E6C58.6050301@jp.fujitsu.com>	 <20051213064800.GB7401@redhat.com> <1134476618.11732.7.camel@localhost.localdomain>
In-Reply-To: <1134476618.11732.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Alan,

Alan Cox wrote:
> This is done deliberately on some systems and is why we have the patches
> I submitted to Andrew Morton which are in his tree and allow you to set
> "panic_on_unrecovered_nmi" to halt on a memory error.
> 
> See the -mm tree. The functionality is there. Also see the various
> x86-64 logging tools which can parse out MCE based reports.

I could find your code in the -mm tree. It looks good :-)
But just one point, isn't it better to use die_nmi() instead of panic()?

 >>        if (panic_on_unrecovered_nmi)
 >>                panic("NMI: Not continuing");

H.Seto

