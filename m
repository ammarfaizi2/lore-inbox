Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281181AbRKHAco>; Wed, 7 Nov 2001 19:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281189AbRKHAce>; Wed, 7 Nov 2001 19:32:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31238 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281181AbRKHAcX>; Wed, 7 Nov 2001 19:32:23 -0500
Message-ID: <3BE9D28C.4020402@zytor.com>
Date: Wed, 07 Nov 2001 16:32:12 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: antirez <antirez@invece.org>
CC: "Brenneke, Matthew Jeffrey (UMR-Student)" <mbrennek@umr.edu>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Yet another design for /proc. Or actually /kernel.
In-Reply-To: <6CAC36C3427CEB45A4A6DF0FBDABA56D59C91D@umr-mail03.cc.umr.edu> <20011108012051.C568@blu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

antirez wrote:

> On Wed, Nov 07, 2001 at 03:13:25PM -0600, Brenneke, Matthew Jeffrey (UMR-Student) wrote:
> 
>>/dev/hda1 /home/mbrennek/stuff\040and vfat rw 0 0
>>
> [snip]
> 
>>Are you refering to the 040?
>>
> 
> This works but, if /proc will really be replaced, another
> idea can be to organize the stuff to get something of more
> coherent than:
> 
> value1a value1b value1c
> value2a value2b value2c
> 
> that's more human readable than machine parsable.
> Something that can fix both the problems (quoting and format) is
> the following:
> 
> put every string inside () and only quotes ( and ) with \
> and quotes \ itself with \\, than use brackets to delimit
> string _and_  provide information about the format:
> 
> ((dev/hda1)(/home/mbrennek/stuff and)(vfat)(rw)(0)(0))
> ((/dev/hda2)(/var/tmp)(ext2)(rw)(0)(0))
> 
> and so on. With a simple parser you get a safe delimiter
> for a single element and you know that there are two "objects"
> of 6 elements.
> 


You still need quoting, so why on earth does this make it easier to parse?
 It doesn't; it just makes it harder to read for humans.

	-hpa


