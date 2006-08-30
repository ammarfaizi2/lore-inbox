Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWH3DrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWH3DrJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 23:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWH3DrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 23:47:09 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:53699 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751347AbWH3DrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 23:47:05 -0400
Message-ID: <44F50A0A.2040800@gentoo.org>
Date: Tue, 29 Aug 2006 23:46:18 -0400
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060818)
MIME-Version: 1.0
To: sergio@sergiomb.no-ip.org
CC: bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Chris Wedgwood <cw@f00f.org>, greg@kroah.com, jeff@garzik.org,
       harmon@ksu.edu
Subject: Re: [PATCH] VIA IRQ quirk fixup only in XT_PIC mode Take 2
References: <1154091662.7200.9.camel@localhost.localdomain>	 <44DE5A6F.50500@gentoo.org> <1156906638.3022.18.camel@localhost.portugal>
In-Reply-To: <1156906638.3022.18.camel@localhost.portugal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergio Monteiro Basto wrote:
> I remember check my emails that I send to Len Brown about this subject.
> And I found, what I want, is just revert one patch of Bjorn Helgaas :)
> between kernel 2.6.12-rc5 and 6.13.

It does look like this patch was under discussion of being reverted 
before. See http://lkml.org/lkml/2005/9/26/183

The following comment still stands when we just revert Bjorn's change:

>> I'm reasonably certain that this patch will apply the quirks on the 
>> affected systems again, so I'm happy for it to be applied, people will 
>> be able to use their hardware again. However I'm not sure how good a 
>> solution it is, because in some circumstances it will apply the quirks 
>> to VIA PCI cards on non-VIA boards, which was the reason we messed with 
>> this code in the first place. We could possibly merge it with the 
>> southbridge detection hack, but it gets a bit silly at that point...

So perhaps the best solution is a combination of reverting Bjorn's 
patch, adding Linus' suggested change, and adding my southbridge hack.

Daniel
