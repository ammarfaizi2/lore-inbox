Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVCZEDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVCZEDs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 23:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVCZEDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 23:03:47 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:36363 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S262025AbVCZEC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 23:02:58 -0500
Message-ID: <4244C57A.6040609@lougher.demon.co.uk>
Date: Sat, 26 Mar 2005 02:14:18 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041012)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Phil Lougher <phil.lougher@gmail.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Squashfs without ./..
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr>	 <20050323174925.GA3272@zero>	 <Pine.LNX.4.62.0503241855350.18295@numbat.sonytel.be>	 <20050324133628.196a4c41.Tommy.Reynolds@MegaCoder.com>	 <d1v67l$4dv$1@terminus.zytor.com>	 <3e74c9409b6e383b7b398fe919418d54@mac.com> <cce9e37e0503251948527d322b@mail.gmail.com> <4244DC6A.3020304@zytor.com>
In-Reply-To: <4244DC6A.3020304@zytor.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Phil Lougher wrote:
> 
>>
>> Making readdir return '.' and '..' is trivially easy, as all the
>> required information to fake '.' and '..' entries are present.
>>
>> The lack of '.' and '..' entries hasn't caused any problems despite
>> cramfs/squashfs being used for a large number of years.  I'm inclined
>> to believe any application that _relies_ on seeing '.' and '..'
>> returned by readdir is broken.  This situation is easily fixed within
>> the application rather than forcing the filesystem to unnecessarily
>> fake '.' and '..' entries which are never used.
>>
> 
> <sarcasm>
> 
> Yeah, let's fix every broken application on the planet instead of fixing 
> it in one place...
> 
> </sarcasm>
> 

Fixing it in Squashfs implies Squashfs is broken.  It isn't.  If it has 
to be "fixed" in the kenel, fix it in the VFS, it is after all the VFS 
which makes '.' and '..' handling redundant in the filesystem.

>     -hpa
> 

