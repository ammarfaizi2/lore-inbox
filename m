Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267506AbUHJQil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267506AbUHJQil (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267522AbUHJQgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:36:51 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:50200 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S267506AbUHJQXU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:23:20 -0400
Date: Tue, 10 Aug 2004 18:25:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Chirag Pandya <searchformehere@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling External Modules - Local Include Files
Message-ID: <20040810162523.GB7437@mars.ravnborg.org>
Mail-Followup-To: Chirag Pandya <searchformehere@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20040810150232.3937.qmail@web12506.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810150232.3937.qmail@web12506.mail.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please add lkml on cc: when sending mails direct. I nthis way the list readers also
see the response.

On Tue, Aug 10, 2004 at 08:02:32AM -0700, Chirag Pandya wrote:
> I'm having trouble recompiling my 2.4 modules that
> contain local include files.  Here is the scenario:
> Dir contents
> ------------
> /home/radar/dirA/local.h
> /home/radar/dirB/main.c
> /home/radar/dirB/Makefile
> 
> main.c
> ------
> #include "dirA/local.h"
> main ()
> {
> /* Module Code*/
> }
> 
> Using the following make command
> # make -C /usr/src/linux-2.6.7 M=$(PWD) modules

As explained in private mail two options exists:
1) Restructure your code to have .h file in
either the same dir as your code, and in a sub-directory
to the location of your .c files.

2) Use
EXTRA_CFLAGS := -I..

I recommend 1).

	Sam
