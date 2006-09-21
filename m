Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWIUVoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWIUVoN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWIUVoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:44:12 -0400
Received: from terminus.zytor.com ([192.83.249.54]:34712 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750958AbWIUVoM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:44:12 -0400
Message-ID: <45130792.9040104@zytor.com>
Date: Thu, 21 Sep 2006 14:43:46 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Dax Kelson <dax@gurulabs.com>, Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Smaller compressed kernel source tarballs?
References: <1158870777.24172.23.camel@mentorng.gurulabs.com> <20060921204250.GN13641@csclub.uwaterloo.ca>
In-Reply-To: <20060921204250.GN13641@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> On Thu, Sep 21, 2006 at 02:32:57PM -0600, Dax Kelson wrote:
>> Today as I was watching the linux-2.6.18.tar.bz2 slowly download I
>> thought it would be nice if it could be made smaller.
>>
>> The 7zip program/algorithm is free software (LGPL) and can be obtained
>> from http://www.7-zip.org/ and it is distributed with several
>> distributions (it is in Fedora Core 6 extras for example).
>>
> 
> But after you download it once, you can just get the diff next time.
> How is the decompression time on 7zip versus bzip2 and gzip?
> 

7zip (LZMA) decompresses quickly, and the decompressor text is actually 
smaller than the equivalent for gzip.  Quite nice.

What is not nice is the code for the compressor, which is a total mess. 
  I have been holding out on implementing LZMA on kernel.org, because 
just as zip (deflate) didn't become common in the Unix world until an 
encapsulation format that handles things expected in the Unix world, 
e.g. streaming, was created (gzip), I don't think LZMA is going to be 
widely used until there is an "lzip" which does the same thing.  I 
actually started the work of adding LZMA support to gzip, but then 
realized it would be better if a new encapsulation format with proper 
64-bit support everywhere was created.

	-hpa

