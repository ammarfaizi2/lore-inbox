Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVIUFYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVIUFYv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 01:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVIUFYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 01:24:51 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:64113 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750821AbVIUFYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 01:24:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=N/2shucgZoXUzohetumgxEpf7mkw7+wFHzIB6U+K6NSPinUDjqiyEtpsu2GiGB7IC8y5y3J26qbFrX8V6DO3RFJxiWXn2JOK/iNDd/oV/5JiblkzljGd8I0nyDSBX+FHlc+mLHaiwORZpvPHEnS9N+JsJR6JPaEynLTr4onZ80E=  ;
Message-ID: <4330EE96.6070801@yahoo.com.au>
Date: Wed, 21 Sep 2005 15:24:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       joe-lkml@rameria.de, George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] NTP shift_right cleanup (v. A3)
References: <1126720091.3455.56.camel@cog.beaverton.ibm.com>	 <1127179730.11080.3.camel@cog.beaverton.ibm.com> <1127273050.11080.34.camel@cog.beaverton.ibm.com>
In-Reply-To: <1127273050.11080.34.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:

> 
>+/* Required to safely shift negative values */
>+#define shift_right(x, s) ({	\
>+	__typeof__(x) __x = (x);	\
>+	__typeof__(s) __s = (s);	\
>+	__x < 0 ? -(-__x >> __s) : __x >> __s;	\
>+})
>+
>

I'd hate to be the one to make you do another version of this ;)

However, how about having something more descriptive than shift_right?
signed_shift_right / shift_right_signed, maybe?

Nick


Send instant messages to your online friends http://au.messenger.yahoo.com 
