Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318227AbSGRQYa>; Thu, 18 Jul 2002 12:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318251AbSGRQY3>; Thu, 18 Jul 2002 12:24:29 -0400
Received: from mail.storm.ca ([209.87.239.66]:25744 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S318227AbSGRQY2>;
	Thu, 18 Jul 2002 12:24:28 -0400
Message-ID: <3D36DF91.593F6F65@storm.ca>
Date: Thu, 18 Jul 2002 11:32:33 -0400
From: Sandy Harris <pashley@storm.ca>
Organization: Flashman's Dragoons
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: close return value
References: <Pine.LNX.3.95.1020718104807.19207A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On 18 Jul 2002, Patrick J. LoPresti wrote:
> 
> > Pete Zaitcev <zaitcev@redhat.com> writes:
> >
> > > The problem with errors from close() is that NOTHING SMART can be
> > > done by the application when it receives it.
> >
> > This is like saying "nothing smart" can be done when write() returns
> > ENOSPC.  Such statements are either trivially true or blatantly false,
> > depending on what you mean by "smart".
> >
> > Failures happen.  They can happen on write(), they can happen on
> > close(), and they can happen on any system call for which the API
> > allows it.  There is no difference!  Your application either deals
> > with them and is correct or fails to deal with them and is broken.
> >
> > If the API allows an error return, you *must* check for it, period.
> [SNIPPED..]
> 
> Well no. Many procedures are called for effect. When is the last
> time you checked the return-value of printf() or puts()? If your
> code does this it's wasting CPU cycles.

There's a classic paper on this:
http://www.apocalypse.org/pub/u/paul/docs/canthappen.html
