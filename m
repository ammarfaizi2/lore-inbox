Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbTGAQUS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 12:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbTGAQUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 12:20:18 -0400
Received: from terminus.zytor.com ([63.209.29.3]:63176 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262593AbTGAQUN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 12:20:13 -0400
Message-ID: <3F01B80D.2010707@zytor.com>
Date: Tue, 01 Jul 2003 09:34:21 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Andy Isaacson <adi@hexapodia.org>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI domain stuff
References: <bdr7a6$4eu$1@cesium.transmeta.com> <1057039376.32118.3.camel@rth.ninka.net> <3F0124FC.1010001@zytor.com> <20030630.230329.35692088.davem@redhat.com> <20030701113043.A27060@hexapodia.org>
In-Reply-To: <20030701113043.A27060@hexapodia.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson wrote:
> On Mon, Jun 30, 2003 at 11:03:29PM -0700, David S. Miller wrote:
> 
>>   From: "H. Peter Anvin" <hpa@zytor.com>
>>   Date: Mon, 30 Jun 2003 23:06:52 -0700
>>
>>   Perhaps a libdirectio would be useful?
>>   
>>The details are very PCI specific, so what you'd be working
>>on initially is a PCI centric library.
>>
>>Over time things can be abstracted, but the initial PCI specific
>>one would be good enough for xfree86 to link to and make use
>>of which is a huge step in the right direction.
> 
> 
> There is some interest in the NetBSD project for such an API, as well.
> <fair at netbsd.org> filed xsrc/21986 last week.
> http://www.netbsd.org/cgi-bin/query-pr-single.pl?number=21986
> 
> Perhaps a common implementation could develop.
> 
> (OK, I can dream...)
> 

Right, and the article brings up a particularly nasty issue -- PCI 
probing from userspace is dangerous as it's inherently not atomic.  That 
really *is* the kernel's job, and abstracting that via a library would 
make it a lot less obnoxious from XFree86's standpoint.

	-hpa


