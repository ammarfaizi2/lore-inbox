Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbVHXVfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbVHXVfE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVHXVfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:35:04 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:28916 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S932266AbVHXVfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:35:02 -0400
In-Reply-To: <1124920244.13833.6.camel@localhost.localdomain>
References: <1124920244.13833.6.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <40A6BCC2-717B-46D1-AE84-219D4DAA43F0@freescale.com>
Cc: "Gala Kumar K.-galak" <galak@freescale.com>,
       <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH 00/15] Remove asm/segment.h from low hanging architectures
Date: Wed, 24 Aug 2005 16:35:05 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Aug 24, 2005, at 4:50 PM, Alan Cox wrote:

> On Mer, 2005-08-24 at 11:43 -0500, Kumar Gala wrote:
>
>> The following set of patches removes the use and existence of
>> asm/segment.h from the architecture ports
>>
>
> You've broken various things by doing this because some driver code
> rightly or wrongly uses segment.h. That is fine because they shouldn't
> do so. However asm/segment.h isn't supoosed to be removed on
> architectures that use segments- like x86, and x86-64. There it is a
> real arch private file and shouldn't be disappearing.
>
> It shouldn't be leaking into drivers any more (eg mxser.c is an  
> offender
> there)

Ok, so it sounds like my patch to remove drivers from include asm/ 
segment.h is fine, and we will leave it up to the various arch  
maintainers to decide if they want to keep asm/segment.h for arch  
specific usage.

- kumar
