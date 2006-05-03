Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbWECG2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbWECG2Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 02:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbWECG2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 02:28:24 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:20384 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S965103AbWECG2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 02:28:23 -0400
In-Reply-To: <17496.6519.733076.663815@cargo.ozlabs.ibm.com>
References: <20060429232812.825714000@localhost.localdomain> <200605020150.14152.arnd@arndb.de> <1900A234-BE31-4292-87E1-5C02F12A440D@kernel.crashing.org> <200605021259.24157.arnd@arndb.de> <801072F8-7701-4BD7-81FB-A8C1AA534C2E@kernel.crashing.org> <17496.6519.733076.663815@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <904F5BD9-1ACB-4936-B390-E4128886824C@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
       cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH 11/13] cell: split out board specific files
Date: Wed, 3 May 2006 08:28:15 +0200
To: Paul Mackerras <paulus@samba.org>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Well, it could run on other platforms, except:
>>>
>>> - it requires a few properties in the device tree (local-mac- 
>>> address,
>>>   firmware), so it should also depend on PPC
>>
>> The portions of code that require OF should have appropriate #ifdef
>> guards.
>
> So you're suggesting that we change the Makefile so we can *add*
> ifdefs?  Usually we do it the other way around. :)

Yeah, what was I thinking.  So use some platform hook instead.

But Arnd of course is right; if the driver (currently) only works
on a certain platform, just mark it as such in the Makefile (erm,
Kconfig file).

Hey, we should probably do that with 90% of all drivers.  But that
is a discussion for some other day :-)


Segher

