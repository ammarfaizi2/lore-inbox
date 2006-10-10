Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbWJJIkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbWJJIkI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 04:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbWJJIkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 04:40:08 -0400
Received: from relay.gothnet.se ([82.193.160.251]:18960 "EHLO
	GOTHNET-SMTP2.gothnet.se") by vger.kernel.org with ESMTP
	id S965107AbWJJIkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 04:40:06 -0400
Message-ID: <452B5C54.6080704@tungstengraphics.com>
Date: Tue, 10 Oct 2006 10:39:48 +0200
From: Thomas Hellstrom <thomas@tungstengraphics.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.6.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
References: <20061009110007.GA3592@wotan.suse.de>	 <1160392214.10229.19.camel@localhost.localdomain>	 <20061009111906.GA26824@wotan.suse.de>	 <1160393579.10229.24.camel@localhost.localdomain>	 <20061009114527.GB26824@wotan.suse.de>	 <1160394571.10229.27.camel@localhost.localdomain>	 <20061009115836.GC26824@wotan.suse.de>	 <1160395671.10229.35.camel@localhost.localdomain>	 <20061009121417.GA3785@wotan.suse.de>	 <452A50C2.9050409@tungstengraphics.com>	 <20061009135254.GA19784@wotan.suse.de>	 <1160427036.7752.13.camel@localhost.localdomain>	 <452B398C.4030507@tungstengraphics.com> <1160466932.6177.0.camel@localhost.localdomain>
In-Reply-To: <1160466932.6177.0.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-BitDefender-Scanner: Mail not scanned due to license constraints
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>>Still, even with NOPAGE_REFAULT or the equivalent with the new fault() code,
>>in the case we need to take this route, (and it looks like we won't have 
>>to),
>>I guess we still need to restart from find_vma() in the fault()/nopage() 
>>handler to make sure the VMA is still present. The object mutex need to 
>>be dropped as well to avoid deadlocks. Sounds complicated.
> 
> 
> But as we said, it should be enough to do the flag change with the
> object mutex held as long as it's after unmap_mapped_ranges()
> 
> Ben.
> 
> 
Agreed.
/Thomas



