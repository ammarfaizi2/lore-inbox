Return-Path: <linux-kernel-owner+w=401wt.eu-S1161321AbXAHPuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161321AbXAHPuw (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 10:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161322AbXAHPuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 10:50:52 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:22395 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161321AbXAHPuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 10:50:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DFdP+LsXcHSMBIQOfeeJfiGKuGm5XsZak4YuVHvVrtqArskXLM+D1o8ApNGDDoQNGl8Dwr1Izvd4+sL5T/PfxAOB74axCxnIey+s6ygXhBfFdzebYYllU9yTGCZTYXAheFkrxbgdtEfO6FFRXcb6OrFwl1evo2NSpgfRmFjYEU8=
Message-ID: <d120d5000701080750w142e1a1w5c2ff2dd586331eb@mail.gmail.com>
Date: Mon, 8 Jan 2007 10:50:48 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Peter Osterlund" <petero2@telia.com>,
       "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Linux 2.6.20-rc4
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       kaber@trash.net
In-Reply-To: <m33b6mr1kt.fsf@telia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	 <m37ivyr1v6.fsf@telia.com> <m33b6mr1kt.fsf@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Jan 2007 22:04:02 +0100, Peter Osterlund <petero2@telia.com> wrote:
> Peter Osterlund <petero2@telia.com> writes:
>
> > Linus Torvalds <torvalds@osdl.org> writes:
> >
> > > Patrick McHardy (2):
> > >       [NETFILTER]: New connection tracking is not EXPERIMENTAL anymore
> >
> > I get kernel panics when doing large ethernet transfers. A loop doing
>
> I also see an annoying side effect of this bug. When the panic
> happens, the caps lock LED starts to blink, and the kernel prints this
> on the console once every second (or more often, don't know exactly):
>
>        printk(KERN_WARNING "atkbd.c: Spurious %s on %s. "
>               "Some program might be trying access hardware directly.\n",
>               data == ATKBD_RET_ACK ? "ACK" : "NAK", serio->phys);
>
> This makes the actual crash information disappear before you have a
> chance to read it.
>

I believe I have a fix for this in my tree. I even asked Linus to pull
from it but it is a good thing he did not as I need to revert one
patch to lifebook driver...

Linus, did you not pull because you considered changes to ads7848 and
a new driver gpio-keys unappropriate for this stage or you just missed
my request?

-- 
Dmitry
