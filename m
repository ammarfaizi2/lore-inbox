Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbVKBQHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbVKBQHx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 11:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbVKBQHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 11:07:53 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:55867 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965108AbVKBQHw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 11:07:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ss4XnG0Y4c3SYUddPmhCkvMSoF1GZ7MgIBJUZrPMZ+2rYvpK467TNUIlP6L69DojzqIqeEqNZpgNiJsjjMxo2zoRXRXmcMcRUUlHBJM81GUFyLIPTPm9iriXoeXjYsrXtf0E00rseVFUtVdd6oXrjs2kZowDxkUkNW+KdMpTkpQ=
Message-ID: <cb2ad8b50511020807y4617c6a4pcd0ee27b635c9c34@mail.gmail.com>
Date: Wed, 2 Nov 2005 11:07:51 -0500
From: Carlos Antunes <cmantunes@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.14-rt1
Cc: Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       john stultz <johnstul@us.ibm.com>, Mark Knecht <markknecht@gmail.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1130945876.29788.28.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051030133316.GA11225@elte.hu>
	 <1130900716.29788.22.camel@localhost.localdomain>
	 <cb2ad8b50511011926w11116fdasd22227ca249f18fc@mail.gmail.com>
	 <1130902342.29788.23.camel@localhost.localdomain>
	 <cb2ad8b50511012005g3bc39f36odd0ae1038e2b9b52@mail.gmail.com>
	 <20051102102116.3b0c75d1@mango.fruits.de>
	 <cb2ad8b50511020635qb355f33w6f3638972556c242@mail.gmail.com>
	 <20051102144015.GA19845@elte.hu>
	 <cb2ad8b50511020645i23c164d4h7140c4c352159974@mail.gmail.com>
	 <1130945876.29788.28.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/05, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Sorry I didn't get back to you sooner.  I was already getting ready for
> bed last night when you sent me your program.  So I'm just getting
> around to looking into this now.
>

Hey, a man has got to sleep every now and then! :-)

>
> To answer your question of why SCHED_OTHER may be preforming better than
> SCHED_FIFO (although it shouldn't), probably shows something in either
> the timing code, or the priority inheritance.  Since a SCHED_OTHER
> thread will skip the PI and other things to get it to perform
> reliable.
>

And you know what? The new rt3 solved the problem. Meanig that
SCHED_FIFO now gives better results than SCHED_OTHER.


THANKS INGO!  ;-)



>
> Now could you post/send your CONFIG_FILE. I'm currently getting a test
> machine ready to run your program.
>

Given rt3 changes, do you still need my config?

Thanks!

Carlos


--
"We hold [...] that all men are created equal; that they are
endowed [...] with certain inalienable rights; that among
these are life, liberty, and the pursuit of happiness"
        -- Thomas Jefferson
