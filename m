Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161155AbVICF5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161155AbVICF5a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 01:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161156AbVICF5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 01:57:30 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:57490 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1161153AbVICF5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 01:57:30 -0400
X-Envelope-From: hpa@zytor.com
Message-ID: <43193B46.6080806@zytor.com>
Date: Fri, 02 Sep 2005 22:57:26 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org> <dfapgu$dln$1@terminus.zytor.com> <20050903042859.GA30101@codepoet.org> <AFDE003F-F14F-42CE-B964-2E04A4402406@mac.com>
In-Reply-To: <AFDE003F-F14F-42CE-B964-2E04A4402406@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> 
>> The world would be so much nicer a place if user space were free
>> to #include linux/* header files rather than keeping a
>> per-project private copy of all kernel structs of interest.
> 
> Exactly!  This is why I want to create kcore/* and kabi/* that
> define the appropriate types, then both userspace and the kernel
> could use whatever types fit their fancy, defined in terms of the
> __kcore_ and __kabi_ types, which could be _depended_ on to exist
> because they are guaranteed not to conflict with other namespaces
> 

Agreed.  We should use well-defined namespaces that won't conflict. 
However, I think the __[us][0-9]+ namespace can be considered 
well-established.

	-hpa
