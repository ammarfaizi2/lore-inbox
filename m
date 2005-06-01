Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVFACTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVFACTk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 22:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVFACSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 22:18:05 -0400
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:43748 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261237AbVFACOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 22:14:17 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: Machine Freezes while Running Crossover Office
Date: Wed, 1 Jun 2005 10:07:26 +1000
User-Agent: KMail/1.8
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Pekka Enberg <penberg@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <84144f0205052911202863ecd5@mail.gmail.com> <20050531184101.GA3175@elte.hu> <1117574407.9231.3.camel@localhost>
In-Reply-To: <1117574407.9231.3.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506011007.26650.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005 07:20 am, Pekka Enberg wrote:
> On Tue, 2005-05-31 at 20:41 +0200, Ingo Molnar wrote:
> > Now, assuming you can confirm that doing:
> >
> >   echo 5 > /proc/sys/kernel/INTERACTIVE_DELTA
>
> The hang goes away with a magic number of 6 (although it does not seem
> as smooth as with turning off interactivity completely). With 5, I still
> get the hang but it is noticeable shorter than before. Number 4 gives me
> the same old hang.
>
> Ingo, are there other patches you wanted me to try out?

Generally when I was playing with it I found that if something was critically 
dependant on the _value_ of a tunable rather than the algorithm design, it 
would simply take a different piece of hardware or test case to induce the 
problem, and the algorithm would have to be changed instead of tweaking the 
parameters. This will require a some thought as to the design and an 
algorithm change for the long term rather than tweaking a value :-|

None of this behaviour existed when the interactivity code went in during 2.5 
and I could never have anticipated this pipe design change coming and 
affecting it in this way.

Con
