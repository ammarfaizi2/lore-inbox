Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267232AbSIRQQz>; Wed, 18 Sep 2002 12:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267253AbSIRQQz>; Wed, 18 Sep 2002 12:16:55 -0400
Received: from relay1.pair.com ([209.68.1.20]:5389 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S267232AbSIRQQy>;
	Wed, 18 Sep 2002 12:16:54 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3D88AA12.9D52C892@kegel.com>
Date: Wed, 18 Sep 2002 09:30:10 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Hardware limits on numbers of threads?
References: <3D88208E.8545AAA2@kegel.com> <3D882500.2000105@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> > http://people.redhat.com/drepper/glibcthreads.html says:
> >
> >>Hardware restrictions put hard limits on the number of
> >>threads the kernel can support for each process. ...
> >
> > Is this true?  Where does the limit come from?
> 
> This was and is true with the kernel before 2.5.3<mumble> when Ingo
> introduced TLS support since the thread specific data had to be
> addressed via LDT entries and the LDT holds at most 8192 entries.  The
> GDT based solution now implemented in the kernel has no such limitation
> and the number of threads you can create with the new thread library is
> only limited by system resources.

Thanks.  I've updated http://www.kegel.com/c10k.html#threaded
accordingly.

- Dan
