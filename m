Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWDSNIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWDSNIk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 09:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWDSNIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 09:08:39 -0400
Received: from smtp.tele.fi ([192.89.123.25]:48340 "EHLO smtp.tele.fi")
	by vger.kernel.org with ESMTP id S1750719AbWDSNIj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 09:08:39 -0400
Content-class: urn:content-classes:message
Subject: RE: searching exported symbols from modules
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Wed, 19 Apr 2006 16:08:37 +0300
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <963E9E15184E2648A8BBE83CF91F5FAF43619A@titanium.secgo.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: searching exported symbols from modules
Thread-Index: AcZjsQ73+MAmhsxjT/CqSBg95Y/ULQAADXsg
From: "Antti Halonen" <antti.halonen@secgo.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dick,

Thanks for your response.

> `insmod` (or modprobe) does all this automatically. Anything that's
> 'extern' will get resolved. You don't do anything special. You can
> also use `depmod` to verify that you won't have any problems loading.
> `man depmod`.

Yes, I know insmod and herein the problem lies. I have a module where
I want to use functions provided by another module, _if_ it is present, 
otherwise use modules internal functions. 

So if I hardcode the function calls statically in my module, the insmod
goes trough of course, if the service module is present. But, it fails
if it's not. 

So, I want to load up, check if the service module is present, and use
it's servides.
 
> If you are accessing functions or other objects that are not exported
> anymore, how do you know that they even exist? 

I meant that in previous kernel version, some module symbol searching
functions were available.

Br,
antti
