Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272902AbTHKRIE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272899AbTHKRHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:07:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4616 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S272902AbTHKRHX (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Mon, 11 Aug 2003 13:07:23 -0400
Subject: Re: volatile variable
From: Robert Love <rml@tech9.net>
To: root@chaos.analogic.com
Cc: David Woodhouse <dwmw2@infradead.org>,
       Dinesh Gandhewar <dinesh_gandhewar@rediffmail.com>,
       mlist-linux-kernel@nntp-server.caltech.edu
In-Reply-To: <Pine.LNX.4.53.0308110944350.17240@chaos>
References: <20030801105706.30523.qmail@webmail28.rediffmail.com>
	 <Pine.LNX.4.53.0308010723060.3077@chaos>
	 <1060608783.19194.13.camel@passion.cambridge.redhat.com>
	 <Pine.LNX.4.53.0308110944350.17240@chaos>
Content-Type: text/plain
Message-Id: <1060621622.684.84.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Mon, 11 Aug 2003 10:07:02 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-11 at 07:06, Richard B. Johnson wrote:

> The regparm(0) atttibute tells gcc that schedule() will get any/all
> of its parameters in registers. Since schedule() receives no parameters,
> that means that, as far as gcc is concerned, it cannot modify
> anything. That said, this may be a bug or it may have been added
> to work around some gcc bug. But, nevertheless, as the declaration
> stands, schedule() will never modify anything because somebody told
> gcc it won't.

No, regparm(0) means "zero parameters in registers", so everything is to
be found on the stack.

Also, the notion of functions as compiler barriers has nothing to do
with arguments. It has to do with global variables and pointers from
who-knows-where.

All functions are compile barriers, regardless of regparm() magic or the
number of parameters, with the exception of functions with the gcc
'pure' keyword.

Also, sleep_on() is deprecated and bad. Thanks for trolling today.

	Robert Love


