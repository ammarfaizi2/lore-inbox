Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWBUQiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWBUQiG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 11:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWBUQiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 11:38:06 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:50866 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932320AbWBUQiF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 11:38:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mQcxEHETX+gCF47MkWaELvXZ5T994BGZfY8fPIwNqjyAqiK9LG3Kc76VgdclOlEYWxpyz54DEKzoEbRxuHYA8tMlUfLbjx04vBcSeiwdijjOeUsWwovcRaX/HNDdUE8lW0WTEhwiBbdpZiFeDywhPhxM70CR3dYDuA1vV54mthQ=
Message-ID: <a36005b50602210838wa87764eof7b5d6e5a8a5ab3a@mail.gmail.com>
Date: Tue, 21 Feb 2006 08:38:04 -0800
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Subject: Re: [patch 5/6] lightweight robust futexes: i386
Cc: "Ingo Molnar" <mingo@elte.hu>, "Thomas Gleixner" <tglx@linutronix.de>,
       "Andrew Morton" <akpm@osdl.org>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Ulrich Drepper" <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200602211056_MC3-1-B8E9-59D2@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602211056_MC3-1-B8E9-59D2@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/06, Chuck Ebbert <76306.1226@compuserve.com> wrote:
> > +             : "=a" (oldval), "=m" (*uaddr)
>                                  ^^^^
>    Should be "+m" because it's both read and written.

No, this is why there is the "0" input parameter.


\> > +             : "memory"
>                   ^^^^^^^^
>    Is this necessary? Every possible memory location that could be
> affected has been listed in the operands if the above change is made.

This makes the asm a barrier for the compiler.
