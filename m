Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131393AbRCNOff>; Wed, 14 Mar 2001 09:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131385AbRCNOfZ>; Wed, 14 Mar 2001 09:35:25 -0500
Received: from [64.64.109.142] ([64.64.109.142]:46096 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S131384AbRCNOfS>; Wed, 14 Mar 2001 09:35:18 -0500
Message-ID: <3AAF811F.9C4F83E2@didntduck.org>
Date: Wed, 14 Mar 2001 09:33:03 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: mshiju@in.ibm.com
CC: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ISAPNP :driver not recognized when compiled in kernel
In-Reply-To: <CA256A0F.004A726A.00@d73mta05.au.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mshiju@in.ibm.com wrote:
> 
> Hello,
>            I have a basic question. Can we build a PnP ISA driver in kernel
> with ISAPNP kernel option enabled so that kernel PnP does the job of
> allocating the resources for the driver. The problem being that the
> /etc/isapnp.conf should be executed before the device driver. I tried this
> and was unsuccessful but worked fine when the driver was compiled as a
> module. I read somewhere that ISAPNP drivers with ISAPNP enabled in kernel
> should only be build as modules so that we can keep the order of execution
> . Is this true.? Have any one of you tried this .
> 
> Thanks & Regards
> Shiju

If you build ISAPnP support into the kernel you should not be using the
isapnp userspace tools.  Use on or the other, but not both.  The ISAPnP
system when non-modular is initialized before built-in drivers, so they
do not have to be modular.  With the old userspace tools they must be
modular.

--

				Brian Gerst
