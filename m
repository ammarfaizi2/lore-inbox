Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318122AbSICP5S>; Tue, 3 Sep 2002 11:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318798AbSICP4N>; Tue, 3 Sep 2002 11:56:13 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:29190 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S318122AbSICPzb>;
	Tue, 3 Sep 2002 11:55:31 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209031559.g83FxuI04587@oboe.it.uc3m.es>
Subject: Re: [RFC] mount flag "direct" (fwd)
In-Reply-To: <20020903155638.GA30659@tapu.f00f.org> from Chris Wedgwood at "Sep
 3, 2002 08:56:38 am"
To: Chris Wedgwood <cw@f00f.org>
Date: Tue, 3 Sep 2002 17:59:56 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, Rik van Riel <riel@conectiva.com.br>,
       linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Chris Wedgwood wrote:"
> On Tue, Sep 03, 2002 at 05:50:42PM +0200, Peter T. Breuer wrote:
> 
>     Yes, I do have synchronization - locks are/can be shared between both
>     kernels using a device driver mechanism that I implemented.
> 
> What happens if one of the kernels/nodes dies?

With the lock held, you mean? Depends on policy. There are two
implemented at present:

   a) show all errors
   b) hide all errors

In case b) the lock will continue to be held until the other
node comes back up. In case a) the lock will be abandoned after
timeout, and pending requests will be errored.

I'll explore the ramifications later.

Peter
