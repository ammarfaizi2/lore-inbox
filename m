Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWDUVPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWDUVPF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 17:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWDUVPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 17:15:04 -0400
Received: from pproxy.gmail.com ([64.233.166.177]:54169 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964782AbWDUVPC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 17:15:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dy6HJZA2KzCWPvzThaU0JWiKwSt9OurFjKxcNILV2H1nbw5jV6r+Pqk/VcLmDOvulxjQRUPBhuF/52q9C+7anyfWzfIKgRgXEhbhFu39kc+xELXwReDUi/VyJwTgqIF8xUFZr8EGWyWHpcC3DdcsVJTyYBE/uJNcKugylcyyguo=
Message-ID: <2a56523e0604211415t71eaa390v995681d79c95caee@mail.gmail.com>
Date: Fri, 21 Apr 2006 17:15:01 -0400
From: "Professor Moriarty" <bofh.h4x@gmail.com>
To: DM-Crypt <dm-crypt@saout.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Crypto Hardware Accelerator
In-Reply-To: <20060421093451.GD21627@cip.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060421093451.GD21627@cip.informatik.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello everyone,
> I am looking for a crypto hardware accelerator which is available in the
> EU in form of a PCI card which is supported by the linux kernel to do a
> device mapper crypt setup using aes256. It would be also nice if it
> could also be used by openssl userland applications. Also I would like
> to know if there are some plans to support IDE drives which do AES
> transparently for the OS. Like an ATA Command which tells the drive
> which AES key to use during startup. An the rest does the device instead
> of the hostos/cpu.
>
>         Thomas
Hello Thomas,

You might have a look at the Soekris vpn1401 card, (technical specs
here: http://www.soekris.com/vpn1401.htm). It is available in the EU
and can do AES256 without a problem.
It does have linux support, though I'm not sure if it can be used by
OpenSSL applications. Typically, you'd have to have the crypto
accelerator take over API calls to en/decrypt for OpenSSL (A crypto
accelerator is basically an FPGA with the required algos coded in), so
I'm not too sure if it is possible to do this without actually editing
OpenSSL's code directly

~ Vasily Ivanov
