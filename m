Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbUB2Kfe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 05:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbUB2Kfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 05:35:34 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:25577 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S262037AbUB2Kf2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 05:35:28 -0500
Message-ID: <4041C060.8090704@matchmail.com>
Date: Sun, 29 Feb 2004 02:35:12 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paolo Ornati <ornati@fastwebnet.it>
CC: Alex Bennee <kernel-hacker@bennee.com>, Rik van Riel <riel@redhat.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.x: iowait problem while burning a CD
References: <Pine.LNX.4.44.0402271915590.1747-100000@chimarrao.boston.redhat.com> <200402281014.19842.ornati@fastwebnet.it> <1077979936.2791.69.camel@cambridge.braddahead.com> <200402291027.34655.ornati@fastwebnet.it>
In-Reply-To: <200402291027.34655.ornati@fastwebnet.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati wrote:
> On Saturday 28 February 2004 15:52, Alex Bennee wrote:
> 
>>>>At that point, mkisofs is probably running into a bazillion
>>>>small files, in subdirectories all over the place.
>>>>
>>>>Because a disk seek + track read takes 10ms, it's simply not
>>>>possible to read more than maybe 100 of these small files a
>>>>second, so mkisofs can't keep up.
>>>
>>>No... mkfs is reading only ONE big file ( ~ 700 MB )!
>>>
>>>And my system shouldn't be so slow:
>>>
>>>CPU: AMD Duron 750
>>>RAM: 128 MB PC100
>>>HD: 7200 RPM udma 4
>>>File System: ResiserFS
>>
>>Could this be related to your low(ish) physical memory and the need swap
>>stuff in and out? Maybe you could look at the vmstat output as you run
>>the two cases?
> 
> 
> No... swap is never touched !
> 
> But I think to have found where the problem is:
> 
> if I only create an ISO image of 672.4 MB I must wait more then 5 minutes... 
> this means about 2.2 MB/s !

How full is your filesystem on average?  If it has been around 90% or 
more, you might be having trouble with fragmentation.
