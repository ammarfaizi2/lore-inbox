Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWDTBdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWDTBdP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 21:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWDTBdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 21:33:14 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:32227 "EHLO
	victor.provo.novell.com") by vger.kernel.org with ESMTP
	id S1750722AbWDTBdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 21:33:14 -0400
Message-ID: <4446E4AE.1090901@novell.com>
Date: Wed, 19 Apr 2006 18:32:30 -0700
From: Crispin Cowan <crispin@novell.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: grundig <grundig@teleline.es>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <p73mzeh2o38.fsf@bragg.suse.de> <20060420011037.6b2c5891.grundig@teleline.es> <200604200138.00857.ak@suse.de>
In-Reply-To: <200604200138.00857.ak@suse.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thursday 20 April 2006 01:00, grundig wrote:
>   
>> From my user POV it seems
>> really weird that a feature forbids you from using another unrelated feature
>>     
> e.g. using a firewall usually prevents some applications
> from working. Or using hugepages is not compatible with a lot of other VM
> features. Or some locking doesn't work over NFS.
>   
Exactly. The basic function of an access control system is to block
access, selectively. So it is quite natural for AppArmor, and SELinux,
to block access to various kernel features at various times. Because
AppArmor is fundamentally name-based access control, changes to the name
space affect AppArmor, and thus access to changing the name space must
be managed.

Our controls on changing the name space have rather poor granularity at
the moment. We hope to improve that over time, and especially if LSM
evolves to permit it. This is ok, because as Andi pointed out, there are
currently few applications using name spaces, so we have time to improve
the granularity.

Crispin
-- 
Crispin Cowan, Ph.D.                      http://crispincowan.com/~crispin/
Director of Software Engineering, Novell  http://novell.com

