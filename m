Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271717AbTHHRGp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 13:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271718AbTHHRGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 13:06:45 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:54532 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S271717AbTHHRGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 13:06:43 -0400
Message-ID: <3F33D840.2B9CDB03@SteelEye.com>
Date: Fri, 08 Aug 2003 13:05:04 -0400
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: ldl@aros.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0 NBD driver: remove send/recieve race for request
References: <3F2FE078.6020305@aros.net>
		<3F300760.8F703814@SteelEye.com>
		<3F303430.1080908@aros.net>
		<3F30510A.E918924B@SteelEye.com>
		<3F30AF81.4070308@aros.net>
		<3F332ED7.712DFE5D@SteelEye.com> <20030807222718.5ef37049.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Paul Clements <Paul.Clements@SteelEye.com> wrote:
> >
> > Here's the patch to fix up several race conditions in nbd. It requires
> >  reverting the already included (but admittedly incomplete)
> >  nbd-race-fix.patch that's in -mm5.
> >
> >  Andrew, please apply.
> 
> Sure.  Could I please have a summary of what races were fixed, and how?

I outlined the other races in the mail I just sent. In addition, the
updated patch will fix an Oops where lo->sock gets set to NULL (by
NBD_CLEAR_SOCK) before NBD_DO_IT completes. This can happen when
"nbd-client -d" is called to disconnect the nbd socket.

--
Paul
