Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVCNPTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVCNPTO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 10:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVCNPTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 10:19:13 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:57487 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261536AbVCNPSx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 10:18:53 -0500
In-Reply-To: <1110812661.5863.7.camel@gaston>
References: <20050301211824.GC16465@locomotive.unixthugs.org> <1109806334.5611.121.camel@gaston> <42275536.8060507@suse.com> <20050303202319.GA30183@suse.de> <42277ED8.6050500@suse.com> <b34edd09a60d945f41bbe123a8321f22@kernel.crashing.org> <1110808986.5863.2.camel@gaston> <0409878c894cf868678d8e5226e20c42@kernel.crashing.org> <1110812661.5863.7.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v619.2)
Message-Id: <b7c54b74795bfea1bb6285d943b25341@kernel.crashing.org>
Cc: Jeff Mahoney <jeffm@suse.com>, Olaf Hering <olh@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] openfirmware: adds sysfs nodes for openfirmware	devices
Date: Mon, 14 Mar 2005 16:19:50 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.619.2)
X-MIMETrack: Itemize by SMTP Server on D12ML064/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 14/03/2005 16:18:47,
	Serialize by Router on D12ML064/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 14/03/2005 16:18:49,
	Serialize complete at 14/03/2005 16:18:49
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I choose the spec.  If an implementation is not conformant to the 
>> spec,
>> it doesn't "work".
>>
>> Not to say that Linux doesn't have to work around bugs in actual
>> implementations, of course.  And there's a lot of those.  Too bad ;-)
>
> Yah, well.. ok, let's say we have a spec... and an implementation that
> represents about 90% of the machines concerned. Those 90% have the
> "bug"... what do you chose ? :)

What do you mean?  I already said we have to work around this bug --
but it IS a bug.  That's all.

> The separator in "compatible", afaik, is \0, not space btw.

Please re-read my original message?  Yes the "separator" is 0x00;
of course it isn't space, as space isn't allowed at all.

> On possibiliy would be to have the kernel replace spaces with
> underscores for the sake of matching. That would make life easier for
> everybody.

Yes, that'll probably work just fine.  Or use 0xb1, showing that this
is "plus-minus" correct :-)


Segher

