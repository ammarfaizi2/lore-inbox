Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbWCXTCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbWCXTCh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWCXTCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:02:37 -0500
Received: from bay0-omc2-s22.bay0.hotmail.com ([65.54.246.158]:10290 "EHLO
	bay0-omc2-s22.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S932550AbWCXTCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:02:36 -0500
Message-ID: <BAY109-DAV2BB627B948B4A363C4436B3DF0@phx.gbl>
X-Originating-IP: [209.167.177.36]
X-Originating-Email: [zhaojingmin@hotmail.com]
From: "Jing Min Zhao" <zhaojingmin@hotmail.com>
To: "Patrick McHardy" <kaber@trash.net>, "Adrian Bunk" <bunk@stusta.de>
Cc: <netdev@vger.kernel.org>, <zhaojingmin@users.sourceforge.net>,
       <netfilter-devel@lists.netfilter.org>, <linux-kernel@vger.kernel.org>
References: <20060324001307.GO22727@stusta.de> <44235324.3080607@trash.net>
Subject: Re: Two comments on the H.323 conntrack/NAT helper
Date: Fri, 24 Mar 2006 14:02:03 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-OriginalArrivalTime: 24 Mar 2006 19:02:35.0597 (UTC) FILETIME=[831AAFD0:01C64F75]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Patrick McHardy" <kaber@trash.net>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: <netdev@vger.kernel.org>; <zhaojingmin@users.sourceforge.net>; <netfilter-devel@lists.netfilter.org>; "Jing Min Zhao" 
<zhaojignmin@hotmail.com>; <linux-kernel@vger.kernel.org>
Sent: Thursday, March 23, 2006 9:02 PM
Subject: Re: Two comments on the H.323 conntrack/NAT helper


> [The hotmail address of the author doesn't work, CCed sourceforge-address]
>
> Adrian Bunk wrote:
>> Two comments on the H.323 conntrack/NAT helper:
>> - the function prototypes in ip_nat_helper_h323.c are _ugly_,
>>   please move them to a header file
>
> Their ugliness is because of the current API, which cleaned up
> quite a lot of the surrounding code, but requires this ugliness
> from each helper. I would like to keep them visible as a reminder
> that a cleaner solution is wanted, but moving them to header
> files certainly sound like a good idea to eliminate the risk
> of prototype conflicts. But please do this for all helpers
> at once.
>
>> - is there a reason for not using EXPORT_SYMBOL_GPL?
>
> I would prefer that too.
>
>

I've moved those prototypes. But the move involves moving of two header files:
ip_conntrack_helper_h323_asn1.h and ip_conntrack_helper_h323_types.h.
This is because ip_conntrack_h323.h now has to include
ip_conntrack_helper_h323_asn1.h and thus ip_conntrack_helper_h323_types.h,
so they are moved from net/ipv4/netfilter/ to include/linux/netfilter_ipv4/ to
make sure other header files like ip_conntrack_h323.h and ip_conntrack.h
be able to find them.

Is this ok or you have a better idea?

Thanks a lot!

Jing Min Zhao
