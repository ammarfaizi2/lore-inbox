Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbVIFNRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbVIFNRm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 09:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbVIFNRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 09:17:42 -0400
Received: from bizon.gios.gov.pl ([212.244.124.8]:51179 "EHLO
	bizon.gios.gov.pl") by vger.kernel.org with ESMTP id S964866AbVIFNRl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 09:17:41 -0400
Date: Tue, 6 Sep 2005 15:17:04 +0200 (CEST)
From: Krzysztof Oledzki <olel@ans.pl>
X-X-Sender: olel@bizon.gios.gov.pl
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@kernel-bugs.osdl.org>,
       Matt LaPlante <laplam@rpi.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: Fw: [Bugme-new] [Bug 5194] New: IPSec related OOps in 2.6.13
In-Reply-To: <20050906122029.GB4594@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.62.0509061516170.27142@bizon.gios.gov.pl>
References: <20050906040856.4e38419f.akpm@osdl.org> <20050906122029.GB4594@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-1869748011-1126012624=:27142"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-1869748011-1126012624=:27142
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Tue, 6 Sep 2005, Herbert Xu wrote:

> On Tue, Sep 06, 2005 at 04:08:56AM -0700, Andrew Morton wrote:
>>
>> Problem Description:
>>
>> Oops: 0000 [#1]
>> PREEMPT
>> Modules linked in:
>> CPU:    0
>> EIP:    0060:[<c01f562c>]    Not tainted VLI
>> EFLAGS: 00010216   (2.6.13)
>> EIP is at sha1_update+0x7c/0x160
>
> Thanks for the report.  Matt LaPlante had exactly the same problem
> a couple of days ago.  I've tracked down now to my broken crypto
> cipher wrapper functions which will step over a page boundary if
> it's not aligned correctly.
>
>
> [CRYPTO] Fix boundary check in standard multi-block cipher processors

Thanks. Patched my kernel, recompiled and waiting. So far it is OK,

Should this patch be merged into 2.6.13.1?

Best regards,

                         Krzysztof Ol=EAdzki

---187430788-1869748011-1126012624=:27142--
