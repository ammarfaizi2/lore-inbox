Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759463AbWLFBe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759463AbWLFBe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 20:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759467AbWLFBe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 20:34:27 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:33766 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759463AbWLFBe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 20:34:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KsteO3MY6O1B/WmCei+nJ/2JYivgheYuTrOGpQU2UlGj7TQ6G7tecdFMQOYjvWr3BjlHL6uSeZKd/sINOtZcRjFdbIILXSDpw8/qN46x3Bv/s9iTTJ3Hk/ee9041jMi9LxweHifpger0csj8zJuk92iQRD5UBu1HANww3GdnvLo=
Message-ID: <f2b55d220612051734v32017a2cg92fde4c57c3d61fe@mail.gmail.com>
Date: Tue, 5 Dec 2006 17:34:25 -0800
From: "Michael K. Edwards" <medwards.linux@gmail.com>
To: "Michael K. Edwards" <medwards.linux@gmail.com>,
       "Linux Kernel List" <linux-kernel@vger.kernel.org>,
       "Sam Ravnborg" <sam@ravnborg.org>,
       linux-arm-toolchain@lists.arm.linux.org.uk,
       linux-arm-kernel@lists.arm.linux.org.uk, crossgcc@sourceware.org
Subject: Re: More ARM binutils fuckage
In-Reply-To: <20061206002226.GK24038@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061205193357.GF24038@flint.arm.linux.org.uk>
	 <f2b55d220612051529t3c0dcda8ma920c13b00899b10@mail.gmail.com>
	 <20061206002226.GK24038@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> There is no such thing as soft VFP.

Patches have been floating around for quite some time that implement
soft float with VFP parameter passing conventions (which notably
implies native endianness, unlike FPA).  They all seem to derive from
Nicolas Pitre's patch at
http://lists.arm.linux.org.uk/pipermail/linux-arm/2003-October/006436.html
, which is said to have some bugs but to supply the majority of the
needed functionality.  (See, for instance,
http://www.busybox.net/cgi-bin/viewcvs.cgi/branches/buildroot.mjn3/toolchain/gcc/3.4.6/arm-softfloat.patch.conditional?rev=14854&view=auto.)
 I assume that I'm not the first to fix it up for gcc 4.1.1.

> I can only talk from the requirements of the kernel.  gcc 3.4.3 is
> the minimum for ARM, which with binutils 2.17 will allow you to build
> the kernel as OABI in *any* configuration.  No patches required for
> either.

It would be nice if this appeared prominently in
Documentation/arm/whatever so that vendors who are stuck on gcc 3.3
(and binutils so old that they comment things out in vmlinux.lds) can
be encouraged to move forward.

Cheers,
- Michael
