Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbVHQBwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbVHQBwq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 21:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVHQBwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 21:52:46 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:2808 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750790AbVHQBwq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 21:52:46 -0400
Message-ID: <43029866.8040605@mvista.com>
Date: Tue, 16 Aug 2005 18:52:38 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 1.0+ (X11/20050531)
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       Todd Poynor <tpoynor@mvista.com>, cpufreq@lists.linux.org.uk,
       Patrick Mochel <mochel@digitalimplant.org>, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: PowerOP 0/3: System power operating point management API
References: <20050809024907.GA25064@slurryseal.ddns.mvista.com> <20050810100718.GC1945@elf.ucw.cz> <42FA796A.4080205@mvista.com> <20050809024907.GA25064@slurryseal.ddns.mvista.com> <Pine.LNX.4.50.0508091110430.19925-100000@monsoon.he.net> <42F963F6.60209@mvista.com> <20050809030000.GA25112@slurryseal.ddns.mvista.com> <20050816085345.GJ9150@dominikbrodowski.de> <20050816085740.GL9150@dominikbrodowski.de>
In-Reply-To: <20050816085740.GL9150@dominikbrodowski.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:
> A small add-on:
> 
> We need to make sure that we're capable of handling smart CPUs like Transmeta
> Crusoe processors in a sane way. This means
> 
> 
>>b)	Setting of "values"
> 
> 
> is optional if the hardware itself can be set to a min/max value (step a
> above in previous mail).

Although I haven't looked into the Crusoe processor support, it may be 
that there is a different set of power parameters, not cpu speed 
directly, that are appropriate to manage on these platforms (after a 
brief look, seems to be a range of frequencies and some sort of flags)? 
  If so, these sorts of machine-specific power parameters are what 
PowerOP is trying to address, allowing management of the underlying 
machine-specific stuff to upper layers that may be presenting an 
abstracted view of power/performance, such as CPU speed or speed ranges, 
to the user.  Thanks,

-- 
Todd
