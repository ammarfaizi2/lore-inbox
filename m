Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVCATsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVCATsy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 14:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVCATsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 14:48:53 -0500
Received: from fire.osdl.org ([65.172.181.4]:21434 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262036AbVCATsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 14:48:50 -0500
Message-ID: <4224C745.4090605@osdl.org>
Date: Tue, 01 Mar 2005 11:49:25 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sam@ravnborg.org, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, ultralinux@vger.kernel.org
CC: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: SPARC64: Modular floppy?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sam, your From: From: Sam Ravnborg <>  really trips thunderbird.)

Sam wrote:
Documentation/kbuild/makefiles.txt is a good start.
For specific questions I can help out.

For this specific case the problem seems to me that you in the ppc64
case want to include floppy-ppc64.S in the build for the PPC64 case.
So something as simple as:

1) rename floppy.c to floppy-core.c

2) Change Makefile to look like:
floppy-y        := floppy-core.o
floppy-$(PPC64) += floppy-ppc64.o
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Minor detail, This is for sparc64 (see Subject).

I also see that arch/arm[26]/lib/ has special handling for
floppydma.S, so there'a a model to consider also.

-- 
~Randy
