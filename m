Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVCNO0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVCNO0K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 09:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVCNO0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 09:26:10 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:52198 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261497AbVCNO0I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 09:26:08 -0500
In-Reply-To: <1110808986.5863.2.camel@gaston>
References: <20050301211824.GC16465@locomotive.unixthugs.org> <1109806334.5611.121.camel@gaston> <42275536.8060507@suse.com> <20050303202319.GA30183@suse.de> <42277ED8.6050500@suse.com> <b34edd09a60d945f41bbe123a8321f22@kernel.crashing.org> <1110808986.5863.2.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v619.2)
Message-Id: <0409878c894cf868678d8e5226e20c42@kernel.crashing.org>
Cc: Jeff Mahoney <jeffm@suse.com>, Olaf Hering <olh@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] openfirmware: adds sysfs nodes for openfirmware	devices
Date: Mon, 14 Mar 2005 15:27:07 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.619.2)
X-MIMETrack: Itemize by SMTP Server on D12ML064/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 14/03/2005 15:26:05,
	Serialize by Router on D12ML064/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 14/03/2005 15:26:06,
	Serialize complete at 14/03/2005 15:26:06
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Is whitespace (in any form) allowed in the compatible value?
>>
>> No.  Only printable characters are allowed, that is, byte values
>> 0x21..0x7e and 0xa1..0xfe; each text string is terminated by a
>> 0x00; there can be several text strings concatenated in one
>> "compatible" property.
>>
>>>> Yes, whitespace is used at least in the toplevel compatible file, 
>>>> like
>>>> 'Power Macintosh' in some Pismo models.
>>
>> So those OF implementations violate the OF specification.
>
> Well, we have an unmaintained spec on one side that can't even be
> ordered from IEEE anymore and actual imlementations that work today,
> what do you chose ? ;)

I choose the spec.  If an implementation is not conformant to the spec,
it doesn't "work".

Not to say that Linux doesn't have to work around bugs in actual
implementations, of course.  And there's a lot of those.  Too bad ;-)


Segher

