Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264974AbSJWNWc>; Wed, 23 Oct 2002 09:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264978AbSJWNWc>; Wed, 23 Oct 2002 09:22:32 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:56766 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264974AbSJWNWb>; Wed, 23 Oct 2002 09:22:31 -0400
Subject: Re: One for the Security Guru's
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021023130251.GF25422@rdlg.net>
References: <20021023130251.GF25422@rdlg.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 14:45:16 +0100
Message-Id: <1035380716.4323.50.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 14:02, Robert L. Harris wrote:
>   The consultants aparantly told the company admins that kernel modules
> were a massive security hole and extremely easy targets for root kits.
> As a result every machine has a 100% monolithic kernel, some of them
> ranging to 1.9Meg in filesize.  This of course provides some other
> sticky points such as how to do a kernel boot image

Modules make no difference to security. If I can add a module I can swap
the kernel and reboot the box, or I can patch the kernel. In fact I can
load modules into module-less kernels its just a bit harder.

> to accept a module we didn't build?  Are there plans to implement some
> form of finger printing on modules down the road?

It doesnt help you without a lot more than just fingerprints. You can
revoke module loading at boot time if you want - it only makes things a
little harder.

If you want to make it theoretically impossible then you need to load
the modules required early then revoke the module loading and rawio
capabilities. At that point I should not be able to get raw hardware
access or load a module. You need to revoke both of the so  I can't for
example hand load modules by poking in /dev/mem.

Alan

