Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751791AbWF1XrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbWF1XrG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbWF1XrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:47:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:33396 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751791AbWF1XrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:47:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fg1PIeqA8Bp158Oj1dt2yOgbnijJOhUfycIQtXaDAkP41v0o2Q6t1kU70DhtwMksoAfzvla4pIzxsB9FkRqSrnkPNwswgzx5VMvqUUT02P9DQW9L9xH1kPe9b8r8qVJPSjO1J1ULixKEzfzpucFkD3v4alSn0cZbIoEzNbgMDPY=
Message-ID: <a36005b50606281647i58f2899eo7ae7e95757969d42@mail.gmail.com>
Date: Wed, 28 Jun 2006 16:47:00 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: make PROT_WRITE imply PROT_READ
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Jason Baron" <jbaron@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060628194913.GA18039@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <fa.PuMM6IwflUYh1MWILO9rb6z4fvY@ifi.uio.no>
	 <449B42B3.6010908@shaw.ca>
	 <Pine.LNX.4.64.0606230934360.24102@dhcp83-5.boston.redhat.com>
	 <1151071581.3204.14.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0606231002150.24102@dhcp83-5.boston.redhat.com>
	 <1151072280.3204.17.camel@laptopd505.fenrus.org>
	 <a36005b50606241145q4d1dd17dg85f80e07fb582cdb@mail.gmail.com>
	 <20060627095632.GA22666@elf.ucw.cz>
	 <a36005b50606280943l54138e80tbda08e1607136792@mail.gmail.com>
	 <20060628194913.GA18039@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/06, Pavel Machek <pavel@ucw.cz> wrote:
> mmap() behaviour always was platform-specific, and it happens to be
> quite strange on i386. So what.

Nonsense.  The mmap semantics is specified in POSIX.  If something
doesn't work as requested it is a bug.  For the specific issue hurting
x86 and likely others the standard explicitly allows requiring
PROT_READ to be used or implicitly adding it.  Don't confuse people
with wrong statement like yours.
