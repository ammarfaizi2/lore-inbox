Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316893AbSGHNND>; Mon, 8 Jul 2002 09:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316895AbSGHNNC>; Mon, 8 Jul 2002 09:13:02 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:43280 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316893AbSGHNNC>;
	Mon, 8 Jul 2002 09:13:02 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal 
In-reply-to: Your message of "Mon, 08 Jul 2002 23:06:05 +1000."
             <17584.1026133565@ocs3.intra.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Jul 2002 23:15:32 +1000
Message-ID: <17857.1026134132@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Jul 2002 23:06:05 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>The current code tries to use 'increment use count outside module' but
>that has its own race in getting the address of the module.  Closing
>that race relies on the interaction between three (yes, three)
>unrelated locks which have to be obtained and released in the right
>order.  Not only is this complex and fragile, a quick scan of the
>kernel found one outright bug and several dubious sections of code.

Correction: make that two outright bugs.  I have just been told that
one of the dubious bits of code is broken.

Tracking the interaction of multiple locks to ensure that they
correctly prevent a race on incrementing the use count is too messy and
fragile.  The offending bits of code were not written by beginners but
by experienced kernel programmers.  If experienced programmers get it
wrong, then the method is wrong.

