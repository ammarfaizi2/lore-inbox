Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWF1UFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWF1UFK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 16:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWF1UFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 16:05:10 -0400
Received: from relay01.pair.com ([209.68.5.15]:29958 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S1751190AbWF1UFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 16:05:08 -0400
X-pair-Authenticated: 71.197.50.189
Date: Wed, 28 Jun 2006 15:05:06 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Pavel Machek <pavel@ucw.cz>
cc: Ulrich Drepper <drepper@gmail.com>, Arjan van de Ven <arjan@infradead.org>,
       Jason Baron <jbaron@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: make PROT_WRITE imply PROT_READ
In-Reply-To: <20060628194913.GA18039@elf.ucw.cz>
Message-ID: <Pine.LNX.4.64.0606281502580.23249@turbotaz.ourhouse>
References: <fa.PuMM6IwflUYh1MWILO9rb6z4fvY@ifi.uio.no> <449B42B3.6010908@shaw.ca>
 <Pine.LNX.4.64.0606230934360.24102@dhcp83-5.boston.redhat.com>
 <1151071581.3204.14.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0606231002150.24102@dhcp83-5.boston.redhat.com>
 <1151072280.3204.17.camel@laptopd505.fenrus.org>
 <a36005b50606241145q4d1dd17dg85f80e07fb582cdb@mail.gmail.com>
 <20060627095632.GA22666@elf.ucw.cz> <a36005b50606280943l54138e80tbda08e1607136792@mail.gmail.com>
 <20060628194913.GA18039@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006, Pavel Machek wrote:

> On Wed 2006-06-28 09:43:22, Ulrich Drepper wrote:
>> On 6/27/06, Pavel Machek <pavel@ucw.cz> wrote:
>>> Usability for "normal" C applications is probably not too high... so
>>> why not work around it in glibc, if at all?
>>
>> Because it wouldn't affect all b inaries.  Existing code could still
>> cause the problem.  Also, there are other callers of the syscalls
>
> _There is no problem_.
>
> mmap() behaviour always was platform-specific, and it happens to be
> quite strange on i386. So what.

Hell, IIRC, on ConvexOS 11, the second argument to mmap() is a /pointer/ 
to the length.

>> (direct, other libcs, etc).  The only reliable way to get rid of this
>> problem is to enforce it in the kernel.  Since the kernel cannot make
>> sense of this setting in all situations it is IMO even necessary since
>> you really don't want to have anything as unstable as this code.
>
> Current kernel behaviour is useful for specialized apps. If you do not
> want to see that weirdness in regular c application, work around it in
> glibc.
> 									Pavel
>

Thanks,
Chase
