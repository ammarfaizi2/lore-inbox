Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbVJKIcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbVJKIcc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 04:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbVJKIcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 04:32:32 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:62149 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751418AbVJKIcc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 04:32:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dXEHOaghp01LbPVvP0vclBDVBG2hTjwINJHMLRRwhzvGYJfFO5eJFZZgccsqZWTZLMLSr/mD+Mf6waLBqAXXysuwvsND2uc0bfKBEH3sUcyJuhu0wantXMKOXgyMaEp0h/ubkOIiuYfSfrX6h+HPxULTimFltf8aLftHtG76tDw=
Message-ID: <9e0cf0bf0510110132y64c5b42dsb2211d4e75d06f15@mail.gmail.com>
Date: Tue, 11 Oct 2005 10:32:31 +0200
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] 2.6.14-rc3 x86: COMMAND_LINE_SIZE
In-Reply-To: <434AD0EB.6000405@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <431628D5.1040709@zytor.com> <4345A9F4.7040000@uni-bremen.de>
	 <434A6220.3000608@gmx.de>
	 <9a8748490510100621x7bc20c42g667cc083d26aaaa2@mail.gmail.com>
	 <434A8082.9060202@zytor.com> <434A8CE8.2020404@gmx.de>
	 <434A8D70.5060300@zytor.com>
	 <20051010171605.GA7793@georg.homeunix.org>
	 <434AB1EB.6070309@gmail.com> <434AD0EB.6000405@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/05, Georg Lippold <georg.lippold@gmx.de> wrote:
>
> Thus, someone could use bootloaders to "patch" the kernel: If the
> bootloader writes a string of arbitary length to some memory region,
> then there is a fair chance that if you make the string just long
> enough, the kernel image gets (partly) overwritten. It resembles a bit
> "Smashing the stack for fun and profit", but this time, it's "Rewriting
> the kernel to your own needs via the bootloader on x86" :)
>
> Same thing for user defined COMMAND_LINE_SIZE. I think that a common
> interface for boot loaders is required. Especially in uncontrolled multi
> user environments like Universities, everything else could lead to
> undesired results.
>

But the address of cmd_line_ptr is defined to be from the end of the
setup to 0xa0000. This is well defined, since the boot loader will
load the kernel, initramfs and cmd_line_ptr to the correct place...
Nothing is overwritten... Then the kernel is up and takes as much as
it needs from cmd_line_ptr.

Best Regards,
Alon Bar-Lev
