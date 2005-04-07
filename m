Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbVDGSxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbVDGSxq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 14:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVDGSxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 14:53:46 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:46645 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262552AbVDGSxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 14:53:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=liSJlFQP5jcvXE0/WO7JVk1q4rC5PchEyhZIUk1Up44TltbSAsIkxzGNTxfoeVcUKwyJjk9boHtkhUyBPlX+OwpoDmMbiiaGQGriBKQ5DU83kxuD/Fmah6YzARTMP5AZKp5t3n2RzoPdBJQYSiD+chSucOMWPpX2LpT8q3qUjSc=
Message-ID: <aec7e5c305040711535bbe07d3@mail.gmail.com>
Date: Thu, 7 Apr 2005 20:53:30 +0200
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH][RFC] disable built-in modules V2
Cc: linux-os@analogic.com, roland@topspin.com, asterixthegaul@gmail.com,
       damm@opensource.se, linux-kernel@vger.kernel.org
In-Reply-To: <20050407102925.2ab27740.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050405225747.15125.8087.59570@clementine.local>
	 <54b5dbf505040618324186678a@mail.gmail.com>
	 <528y3v72al.fsf@topspin.com>
	 <aec7e5c305040701236289aacd@mail.gmail.com>
	 <20050407100147.7b91a2d2.rddunlap@osdl.org>
	 <Pine.LNX.4.61.0504071319430.5977@chaos.analogic.com>
	 <20050407102925.2ab27740.rddunlap@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 7, 2005 7:29 PM, Randy.Dunlap <rddunlap@osdl.org> wrote:
> On Thu, 7 Apr 2005 13:22:57 -0400 (EDT) Richard B. Johnson wrote:
> | Can't you disable module-loading with a module? I think so.
> | You don't need to modify the kernel. Boot-scripts could
> | just load the "final" module and there is nothing that
> | can be done to add another module (or even unload existing
> | ones).
> 
> Sounds likely, but that's not what the patch from Magnus is
> even trying to do.  It's purely for boot-time selection of
> troublesome modules or devices AFAICT.  I've had a few
> occasions to use something like this -- or rebuild a kernel
> or remove a device.

Yes, the idea is to be able to disable misbehaving built-in modules
from the kernel command line. The alternative is of course to disable
the code using the kernel configuration system and rebuild the kernel.

Say a kernel shipped with your favourite distribution crashes your
machine during boot-up - wouldn't it be nice to be able to just
disable the problematic module from the kernel command line instead of
(1) getting the config, (2) getting the distribution-specific patches,
(3) rebuilding the kernel. And if you are lucky you need to (0) setup
a cross compiler and (4) get your hands on a suitable initrd.

/ magnus
