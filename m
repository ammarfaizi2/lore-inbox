Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278042AbRKNWFz>; Wed, 14 Nov 2001 17:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278163AbRKNWFp>; Wed, 14 Nov 2001 17:05:45 -0500
Received: from ns2.cypress.com ([157.95.67.5]:57340 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S278085AbRKNWFh>;
	Wed, 14 Nov 2001 17:05:37 -0500
Message-ID: <3BF2EA76.6010702@cypress.com>
Date: Wed, 14 Nov 2001 16:04:38 -0600
From: Thomas Dodd <ted@cypress.com>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:0.9.5+) Gecko/20011112
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, 
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Keith Owens <kaos@ocs.com.au>
Subject: Re: Modutils can't handle long kernel names
In-Reply-To: <13690.1005366589@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Keith Owens wrote:

> On Fri, 9 Nov 2001 23:23:43 +0100, 
> andersg@0x63.nu wrote:
>>On Fri, Nov 09, 2001 at 04:34:00PM +1100, Keith Owens wrote:
>>> It is not a modutils problem, it is a fixed restriction on the size of
>>> the uname() fields, modutils just uses what uname -r gives it.

> +uts_len		:= 64
> +uts_truncate	:= sed -e 's/\(.\{1,$(uts_len)\}\).*/\1/'


Should this be a fixed length of 64?
Or should it be grabbed form a header somewhere?
So when/if SYS_NMLN/_UTSNAME_LENGTH is changed
longer strings can be used? I check and Solaris 8
defines SYS_NMLN as 257.

Would this break cross-comiling badly?
Are other libc headers needed in the build?

	-Thomas


