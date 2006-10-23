Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWJWOK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWJWOK7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 10:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWJWOK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 10:10:59 -0400
Received: from terminus.zytor.com ([192.83.249.54]:56556 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751284AbWJWOK6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 10:10:58 -0400
Message-ID: <453CCD5E.6060303@zytor.com>
Date: Mon, 23 Oct 2006 07:10:38 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Sandeep Kumar <sandeepksinha@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: PAE and PSE ??
References: <37d33d830610212329o420e0ee4i75e6bddfcf2fb772@mail.gmail.com> <200610221215.26525.rjw@sisk.pl> <453C00B7.3040909@zytor.com> <200610231213.47232.rjw@sisk.pl>
In-Reply-To: <200610231213.47232.rjw@sisk.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> 
> Well, "AMD64 Architecture Programmer’s Manual" says the following:
> 
> The choice of 2 Mbyte or 4 Mbyte as the large physical-page size
> depends on the value of CR4.PSE and CR4.PAE, as follows:
> - If physical-address extensions are enabled (CR4.PAE=1), the
>    large physical-page size is 2 Mbytes, regardless of the value
>    of CR4.PSE.
> - If physical-address extensions are disabled (CR4.PAE=0)
>    and CR4.PSE=1, the large physical-page size is 4 Mbytes.
> - If both CR4.PAE=0 and CR4.PSE=0, the only available page
>    size is 4 Kbytes.
> 

That would be a retroactive redef on the part of AMD; it probably makes 
sense for x86-64 if someone thinks that is may drop support for 4 MB 
pages at some point in the distant future.  Still, I'm not sure Intel 
would agree with the definition as stated, although I haven't looked in 
the docs.

This is all extremely theoretical, since there has never been a chip 
with PAE=1 and PSE=0, and I wouldn't expect one to appear any time soon.

	-hpa
