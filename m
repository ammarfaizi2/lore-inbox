Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbVKYGei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbVKYGei (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 01:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbVKYGei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 01:34:38 -0500
Received: from mail.dvmed.net ([216.237.124.58]:6798 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932287AbVKYGeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 01:34:37 -0500
Message-ID: <4386B073.3080008@pobox.com>
Date: Fri, 25 Nov 2005 01:34:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Small PCI core patch
References: <5bsXq-5uy-3@gated-at.bofh.it> <5bsXq-5uy-1@gated-at.bofh.it> <5btqF-66n-41@gated-at.bofh.it> <5bzmg-66b-1@gated-at.bofh.it> <5bHtG-228-23@gated-at.bofh.it> <43868DCC.9090101@shaw.ca>
In-Reply-To: <43868DCC.9090101@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Robert Hancock wrote: > Jeff Garzik wrote: > >> One
	sticking point is validation: ensuring userspace cannot cause >>
	invalid GPU microcode to be generated. [I can just hear Al Viro >>
	swearing, just thinking about creating secure compilers...] > > > I
	suspect the amount of data going through is large enough that this >
	wouldn't really be practical. I think you'd have to deal with the code
	> generating GPU instructions having to be trusted and have the device
	> interface require root privileges.. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Jeff Garzik wrote:
> 
>> One sticking point is validation:  ensuring userspace cannot cause
>> invalid GPU microcode to be generated.  [I can just hear Al Viro
>> swearing, just thinking about creating secure compilers...]
> 
> 
> I suspect the amount of data going through is large enough that this 
> wouldn't really be practical. I think you'd have to deal with the code 
> generating GPU instructions having to be trusted and have the device 
> interface require root privileges..

All I said was "ensuring userspace cannot cause invalid GPU microcode to 
be generated."

No matter what runs with root priveleges, other graphics processes do 
not, and one must ensure that app clients cannot generate sequences 
which cause the hardware to fail.  Which is a lot more difficult, when 
the unpriveleged app clients are submitting GLSL.

	Jeff


