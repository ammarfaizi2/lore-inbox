Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbTENTq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 15:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbTENTq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 15:46:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15006 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262676AbTENTqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 15:46:55 -0400
Date: Wed, 14 May 2003 12:59:23 -0700 (PDT)
Message-Id: <20030514.125923.102559449.davem@redhat.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       acme@conectiva.com.br
Subject: Re: 2.5 qdisc problem
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030514130838.GJ15261@suse.de>
References: <20030514122624.GA20480@babylon.d2dc.net>
	<20030514125941.GI15261@suse.de>
	<20030514130838.GJ15261@suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jens Axboe <axboe@suse.de>
   Date: Wed, 14 May 2003 15:08:38 +0200
   
   This half-assed back-out from bk current makes it work here, Arnaldo
   could you please fix this??

This is a good clue, thanks for tracking it down this far.
I'll help figure out what's wrong, I can reproduce the problem
here too.

I believe the problem has something to do with changing when the
rtnetlink/netlink init runs, not the socket owner stuff.
