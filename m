Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269958AbTGKN3V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 09:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269957AbTGKN3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 09:29:21 -0400
Received: from mail.ithnet.com ([217.64.64.8]:34822 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S269959AbTGKN3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 09:29:16 -0400
Date: Fri, 11 Jul 2003 15:38:40 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Chris Mason <mason@suse.com>
Cc: marcelo@conectiva.com.br, ia6432@inbox.ru, green@namesys.com,
       linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
Message-Id: <20030711153840.427909e2.skraw@ithnet.com>
In-Reply-To: <1057929320.13317.26.camel@tiny.suse.com>
References: <E19ae9K-000Nas-00.ia6432-inbox-ru@f7.mail.ru>
	<20030710191254.093354d2.skraw@ithnet.com>
	<Pine.LNX.4.55L.0307101458490.25229@freak.distro.conectiva>
	<1057929320.13317.26.camel@tiny.suse.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jul 2003 09:15:21 -0400
Chris Mason <mason@suse.com> wrote:

> > Andrea, Chris, any idea of why this is happening?
> 
> My first guess is that blk_oversized_queue is false but there aren't any
> requests left.  That will pretty much spin in __get_request_wait with
> irqs off, which sounds similar to what he's hitting.
> 
> I think we need this hunk even if it doesn't fix his problem.

Strike!
Your patch solves my problem. I applied it on 2.4.22-pre4 and it now works just
like -pre2 did.
Great Chris, compared to the pretty minimal input I could give ...

Regards,
Stephan

