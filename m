Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbTE0UPB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbTE0UPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:15:01 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:50694 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264127AbTE0UO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:14:59 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrea Arcangeli <andrea@suse.de>, manish <manish@storadinc.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Tue, 27 May 2003 22:25:27 +0200
User-Agent: KMail/1.5.2
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
References: <3ED2DE86.2070406@storadinc.com> <3ED3BDCE.4010200@storadinc.com> <20030527202047.GM3767@dualathlon.random>
In-Reply-To: <20030527202047.GM3767@dualathlon.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305272225.27720.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 22:20, Andrea Arcangeli wrote:

Hi Andrea,


> > 1. Stock 2.4.20
> > 2. 2.4.20 with the io_request_lock removed.
> > The tests on the first one are still going. The tests on the second one
> > showed processes getting stuck for long times (> 5 minutes) and not
> > paused ...
> sorry if it's a dumb question but what is the "io_request_lock removed"
> thing? Hope you didn't delete any io_request_lock, if you did you can
> get worse things than crashes (i.e. mm/fs corruption). the pausing bug
> was a genuine race (quite innocent, if you could trigger a disk unplug
> you could recover from it)
>
> Andrea
funny. I asked him the same ;)

see his response:

-----------------------------------------------------------------------
>what is this io_request_lock patch you are talking about?
>
>ciao, Marc
>
We made some changes to the 2.4.20 kernel to remove the io_request_lock 
and replace with queue_lock and host_lock.
-----------------------------------------------------------------------

ciao, Marc

