Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264024AbRFHP4y>; Fri, 8 Jun 2001 11:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264021AbRFHP4o>; Fri, 8 Jun 2001 11:56:44 -0400
Received: from alpo.casc.com ([152.148.10.6]:12270 "EHLO alpo.casc.com")
	by vger.kernel.org with ESMTP id <S264024AbRFHP42>;
	Fri, 8 Jun 2001 11:56:28 -0400
From: John Stoffel <stoffel@casc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15136.62579.588726.954053@gargle.gargle.HOWL>
Date: Fri, 8 Jun 2001 11:51:15 -0400
To: Tobias Ringstrom <tori@unhappy.mine.nu>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Jonathan Morton <chromi@cyberspace.org>, Shane Nay <shane@minirl.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
        Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>,
        lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: VM Report was:Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.LNX.4.33.0106081532140.2013-100000@boris.prodako.se>
In-Reply-To: <Pine.LNX.4.33.0106081440300.389-100000@mikeg.weiden.de>
	<Pine.LNX.4.33.0106081532140.2013-100000@boris.prodako.se>
X-Mailer: VM 6.92 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Tobias" == Tobias Ringstrom <tori@unhappy.mine.nu> writes:

Tobias> On Fri, 8 Jun 2001, Mike Galbraith wrote:

>> I gave this a shot at my favorite vm beater test (make -j30 bzImage)
>> while testing some other stuff today.

Tobias> Could you please explain what is good about this test?  I
Tobias> understand that it will stress the VM, but will it do so in a
Tobias> realistic and relevant way?

I agree, this isn't really a good test case.  I'd rather see what
happens when you fire up a gimp session to edit an image which is
*almost* the size of RAM, or even just 50% the size of ram.  Then how
does that affect your other processes that are running at the same
time?  

This testing could even be automated with the script-foo stuff to get
consistent results across runs, which is the prime requirement of any
sort of testing.  

On another issue, in swap.c we have two defines for buffer_mem and
page_cache, but the first maxes out at 60%, while the cache maxes out
at 75%.  Shouldn't they both be lower numbers?  Or at least equally
sized?

I've set my page_cache maximum to be 60, I'll be trying to test it
over the weekend, but good weather will keep me outside doing other
stuff...

Thanks,
John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-952-7548
