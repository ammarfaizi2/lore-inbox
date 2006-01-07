Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161022AbWAGTgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbWAGTgd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161027AbWAGTgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:36:33 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:43896 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161022AbWAGTgc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:36:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EJ0KBKXMcW8neWmIq4M2ZCT6COwBx2+4VSCRm9CJ0inFtxZJIDg7EDNOU1k7wE88IH3rDNwnZt/ASynyCRSCvF5RGAc35Pv5jMpONzymklxwUl0GkAde0D9dOcgfTtDMiMlkuihqLLvR6k9Dwe6gkwu2jFfgLRnaAlaluJIO59c=
Message-ID: <86802c440601071136n14a0851we97f6db04f940d68@mail.gmail.com>
Date: Sat, 7 Jan 2006 11:36:31 -0800
From: yhlu <yhlu.kernel@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: Inclusion of x86_64 memorize ioapic at bootup patch
Cc: Andi Kleen <ak@muc.de>, Vivek Goyal <vgoyal@in.ibm.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>
In-Reply-To: <m1ek3k2ojo.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6F7DA19D05F3CF40B890C7CA2DB13A42030949CB@ssvlexmb2.amd.com>
	 <86802c440601061832m4898e20fw4c9a8360e85cfa17@mail.gmail.com>
	 <86802c440601062238r1b304cd4j2d9c8e14a8324618@mail.gmail.com>
	 <86802c440601062320r597d6970i3b120ec90f96abce@mail.gmail.com>
	 <86802c440601070143v44ee9f4dua2dcef2a536d4c73@mail.gmail.com>
	 <m1ek3k2ojo.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MPTABLE in LinuxBIOS is put from 0x20, if the system has too many cpu
and devices (slots)  the mptable will get bigger than 0x464, so it
will use 0x40:67....

We need to put mptable to [0xf0000:0x100000] together with acpi tables.

and if it is bigger than 64k, then we have to put it on special
postion ...from 1K, and pass the posstion of mptable to the kernel via
command line.

I will update the code in LinuxBIOS.

Thanks

YH
