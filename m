Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVDCXDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVDCXDi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 19:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVDCXDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 19:03:38 -0400
Received: from mail.hosted.servetheworld.net ([62.70.14.38]:54714 "HELO
	mail.hosted.servetheworld.net") by vger.kernel.org with SMTP
	id S261942AbVDCXDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 19:03:36 -0400
Message-ID: <42507645.6010808@osvik.no>
Date: Mon, 04 Apr 2005 01:03:33 +0200
From: Dag Arne Osvik <da@osvik.no>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
CC: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
Subject: Re: Use of C99 int types
References: <424FD9BB.7040100@osvik.no> <20050403220508.712e14ec.sfr@canb.auug.org.au> <424FE1D3.9010805@osvik.no> <20050403181318.GW8859@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050403181318.GW8859@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:

>On Sun, Apr 03, 2005 at 02:30:11PM +0200, Dag Arne Osvik wrote:
>  
>
>>Yes, but wouldn't it be much better to avoid code like the following, 
>>which may also be wrong (in terms of speed)?
>>
>>#ifdef CONFIG_64BIT  // or maybe CONFIG_X86_64?
>> #define fast_u32 u64
>>#else
>> #define fast_u32 u32
>>#endif
>>    
>>
>
>... and with such name 99% will assume (at least at the first reading)
>that it _is_ 32bits.  We have more than enough portability bugs as it
>is, no need to invite more by bad names.
>  
>

Agreed.  The way I see it there are two reasonable options.  One is to 
just use u32, which is always correct but sacrifices speed (at least 
with the current gcc).  The other is to introduce C99 types, which Linus 
doesn't seem to object to when they are kept away from interfaces 
(http://infocenter.guardiandigital.com/archive/linux-kernel/2004/Dec/0117.html).

-- 
  Dag Arne

