Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWDXNja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWDXNja (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 09:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWDXNja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 09:39:30 -0400
Received: from stanford.columbia.tresys.com ([209.60.7.66]:31961 "EHLO
	gotham.columbia.tresys.com") by vger.kernel.org with ESMTP
	id S1750749AbWDXNj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 09:39:29 -0400
Message-ID: <444CD507.70004@gentoo.org>
Date: Mon, 24 Apr 2006 09:39:19 -0400
From: Joshua Brindle <method@gentoo.org>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Neil Brown <neilb@suse.de>, Stephen Smalley <sds@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <17484.20906.122444.964025@cse.unsw.edu.au> <444CCE83.90704@gentoo.org> <200604241526.03127.ak@suse.de>
In-Reply-To: <200604241526.03127.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 0616-4, 04/21/2006), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Monday 24 April 2006 15:11, Joshua Brindle wrote:
>
>   
>> Sure but if, instead, it's able to open /var/chroot/etc/shadow which is 
>> a hardlink to /etc/shadow you've bought nothing. You may filter out 
>> worms and script kiddies this way but in the end you are using obscurity 
>> (of filesystem layout, what the policy allows, how the apps are 
>> configured, etc) for security, which again, leads to a false sense of 
>> security.
>>     
>
> AppArmor disallows both chroot and name space changes for the constrained
> application so the scenario you're describing cannot happen. What happens
> with unconstrained applications it doesn't care about by design.
>
> This has been covered several times in this thread already - please pay
> more attention.
I was paying attention, thank you. Can apparmor force an application to 
only start within a certain chroot? So it may not be able to chroot 
during runtime but if you can't be sure that it starts in the chroot the 
argument still applies. Particularly since the app may not even fail to 
run outside the chroot given that it will have access to all the same 
libraries, etc it did inside (due to the paths being the same).


Joshua
