Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269491AbUIZCP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269491AbUIZCP1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 22:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269489AbUIZCP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 22:15:27 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:19082 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269486AbUIZCPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 22:15:15 -0400
Subject: Re: [sched.h 6/8] move aio include to mm.h
From: Lee Revell <rlrevell@joe-job.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040926020637.GS9106@holomorphy.com>
References: <20040925024513.GL9106@holomorphy.com>
	 <20040925032419.GQ9106@holomorphy.com>
	 <20040925032616.GR9106@holomorphy.com> <200409260356.27499.arnd@arndb.de>
	 <20040926020637.GS9106@holomorphy.com>
Content-Type: text/plain
Message-Id: <1096164911.3697.39.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 25 Sep 2004 22:15:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-25 at 22:06, William Lee Irwin III wrote:
> On Samstag, 25. September 2004 05:26, William Lee Irwin III wrote:
> >> This patch moves the aio inclusion from sched.h to mm.h, while leaving
> >> workqueue.h directly included by sched.h; a large sweep is required to
> >> clean up drivers including workqueue.h indirectly via sched.h
> 
> On Sun, Sep 26, 2004 at 03:56:27AM +0200, Arnd Bergmann wrote:
> > FYI: the checkheaders.pl script I recently posted here gives me
> > the following 175 results about potentially incorrect use of
> > workqueue.h.
> 
> Grepping by hand turned up 186 files missing potentially missing direct
> includes of workqueue.h, though I don't have a way to tell if I got
> false negatives.
> 

Can't you just try to build it with allyesconfig and see what breaks?

Lee

