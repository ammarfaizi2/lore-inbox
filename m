Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWDUHda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWDUHda (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 03:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWDUHda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 03:33:30 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15499 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751277AbWDUHd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 03:33:29 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: "Antti Halonen" <antti.halonen@secgo.com>
cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: Re: searching exported symbols from modules 
In-reply-to: Your message of "Wed, 19 Apr 2006 16:08:37 +0300."
             <963E9E15184E2648A8BBE83CF91F5FAF43619A@titanium.secgo.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 21 Apr 2006 17:33:07 +1000
Message-ID: <14930.1145604787@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Antti Halonen" (on Wed, 19 Apr 2006 16:08:37 +0300) wrote:
>
>Hi Dick,
>
>Thanks for your response.
>
>> `insmod` (or modprobe) does all this automatically. Anything that's
>> 'extern' will get resolved. You don't do anything special. You can
>> also use `depmod` to verify that you won't have any problems loading.
>> `man depmod`.
>
>Yes, I know insmod and herein the problem lies. I have a module where
>I want to use functions provided by another module, _if_ it is present, 
>otherwise use modules internal functions. 

symbol_get() and symbol_put().  See include/linux/module.h.  If
symbol_get() returns NULL then the symbol does not exist.

