Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751717AbWEIJDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbWEIJDb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 05:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbWEIJDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 05:03:31 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:10151 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751549AbWEIJDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 05:03:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ly1srG8xVAqep8UWnZFheuwSe9j736Bdwy7KDyQNRGOlA8mIVUO9eV1EaUOCnaJqrn1xIc+nXlYwxl3qbZZfhx2qPmfYUZ0aTf9fepLdhLiHpY4zyL9odj7L3G1sbhwZEScgj1TRni2Ii+g5HCz0eco9pNeNdM43GUpaYh+AOOk=  ;
Message-ID: <4460389E.80402@yahoo.com.au>
Date: Tue, 09 May 2006 16:37:18 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050831 Debian/1.7.8-1sarge2
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Christoph Lameter <clameter@sgi.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Linus Torvalds <torvalds@osdl.org>,
       Daniel Hokka Zakrisson <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx, akpm@osdl.org
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
References: <445E80DD.9090507@hozac.com>  <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>  <84144f020605080131r58ce2a93w6c7ba784a266bbeb@mail.gmail.com>  <84144f020605080134q7e16f37fl385359c634ece8ca@mail.gmail.com>  <Pine.LNX.4.64.0605080807430.3718@g5.osdl.org>  <1147104412.22096.8.camel@localhost>  <Pine.LNX.4.64.0605080913240.3718@g5.osdl.org> <1147116991.11282.3.camel@localhost> <Pine.LNX.4.64.0605082031580.23431@schroedinger.engr.sgi.com> <44603543.8070205@colorfullife.com>
In-Reply-To: <44603543.8070205@colorfullife.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:

> Christoph Lameter wrote:
>
>> virt_to_page is not cheap on NUMA.
>>
>>  
>>
> I know. But it was a design assumption when I wrote the slab allocator.
> Acutally, it's not cheap on non-NUMA either. And the PageCompound() 
> check adds an additional branch.


Just FYI, the PageCompound check can go as soon as nommu stops trying to 
do its
broken page refcounting on slab pages (whenever that happens :P).
--

Send instant messages to your online friends http://au.messenger.yahoo.com 
