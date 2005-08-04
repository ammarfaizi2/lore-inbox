Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262504AbVHDMiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbVHDMiy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 08:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVHDMiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 08:38:54 -0400
Received: from mx1.invoca.ch ([157.161.91.34]:63950 "EHLO ns1.invoca.ch")
	by vger.kernel.org with ESMTP id S262504AbVHDMix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 08:38:53 -0400
Message-ID: <50089.213.188.237.106.1123159119.squirrel@localhost>
In-Reply-To: <20050803180835.GA1043467@hiwaay.net>
References: <fa.joi2dm7.1l4o8in@ifi.uio.no>
    <20050803180835.GA1043467@hiwaay.net>
Date: Thu, 4 Aug 2005 14:38:39 +0200 (CEST)
Subject: Re: File corruption on LVM2 on top of software RAID1
From: "Simon Matter" <simon.matter@invoca.ch>
To: "Chris Adams" <cmadams@hiwaay.net>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Once upon a time, "Simon Matter" <simon.matter@invoca.ch> said:
>>In my tests I get corrupt files on LVM2 which is on top of software
>> raid1.
>>(This is a common setup even mentioned in the software RAID HOWTO and has
>>worked for me on RedHat 9 / kernel 2.4 for a long time now and it's my
>>favourite configuration). Now, I tested two different distributions,
>> three
>>kernels, three different filesystems and three different hardware. I can
>>always reproduce it with the following easy scripts:
>
> See:
>
> http://bugzilla.kernel.org/show_bug.cgi?id=4946
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=152162
>
> There's a one-line patch in there; see if that fixes the problem for
> you.

Hi Chris,

Thank you for your help, indeed this oneliner fixes the corruption. I have
tested with 2.6.12.3 + bio_clone fix and also built an updated RedHat EL4
kernel with the fix included. No corruption anymore.
This fix should be applied to most kernels shipped with the latest Linux
distributions. At least those products called Enterprise something should
hurry in the interest of their customers. Do you think this will happen
anytime soon?

-- 
Simon Matter
Invoca Systems

