Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269961AbTGKNep (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 09:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269962AbTGKNep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 09:34:45 -0400
Received: from 69-55-72-150.ppp.netsville.net ([69.55.72.150]:36551 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S269961AbTGKNeo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 09:34:44 -0400
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
From: Chris Mason <mason@suse.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: marcelo@conectiva.com.br, ia6432@inbox.ru, green@namesys.com,
       linux-kernel@vger.kernel.org, andrea@suse.de
In-Reply-To: <20030711152738.5b26fb4c.skraw@ithnet.com>
References: <E19ae9K-000Nas-00.ia6432-inbox-ru@f7.mail.ru>
	 <20030710191254.093354d2.skraw@ithnet.com>
	 <Pine.LNX.4.55L.0307101458490.25229@freak.distro.conectiva>
	 <1057929320.13317.26.camel@tiny.suse.com>
	 <20030711152738.5b26fb4c.skraw@ithnet.com>
Content-Type: text/plain
Organization: 
Message-Id: <1057931282.13318.39.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Jul 2003 09:48:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-11 at 09:27, Stephan von Krawczynski wrote:
>  
> > My first guess is that blk_oversized_queue is false but there aren't any
> > requests left.  That will pretty much spin in __get_request_wait with
> > irqs off, which sounds similar to what he's hitting.
> 
> Why is it I am only seeing it on a big device of 320 GB? Even 60GB mount
> without problems...

Honestly not sure.  I could make a better guess if you got a stack trace
with nmi_watchdog on, so we could see which part of the reiserfs mount
process was causing problems.

The bug would be easier to hit with smaller blocksizes, I'm running
tests now with ext and 1k blocksizes.

-chris


