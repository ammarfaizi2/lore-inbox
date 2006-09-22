Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWIVQdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWIVQdY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 12:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWIVQdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 12:33:24 -0400
Received: from terminus.zytor.com ([192.83.249.54]:30899 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932533AbWIVQdX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 12:33:23 -0400
Message-ID: <4514103D.8010303@zytor.com>
Date: Fri, 22 Sep 2006 09:33:01 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Dax Kelson <dax@gurulabs.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Smaller compressed kernel source tarballs?
References: <1158870777.24172.23.camel@mentorng.gurulabs.com> <20060921204250.GN13641@csclub.uwaterloo.ca> <45130792.9040104@zytor.com> <20060922140007.GK13639@csclub.uwaterloo.ca> <Pine.LNX.4.61.0609221811560.12304@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0609221811560.12304@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>> widely used until there is an "lzip" which does the same thing.  I 
>>> actually started the work of adding LZMA support to gzip, but then 
>>> realized it would be better if a new encapsulation format with proper 
>>> 64-bit support everywhere was created.
>> It doesn't handle streaming?
>>
>> So you can't do: tar c dirname | 7zip dirname.tar.7z ?
> 
> man 7z [slightly changed for reasonability]:
> 
>   -si
>       Read data from StdIn (eg: tar -c directory | 7z a -si directory.tar.7z)
> 

Yes, but you can't make it write to an unseekable stdout.

	-hpa
