Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265857AbTBKCou>; Mon, 10 Feb 2003 21:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265872AbTBKCou>; Mon, 10 Feb 2003 21:44:50 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:20404 "EHLO
	apone.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265857AbTBKCot>; Mon, 10 Feb 2003 21:44:49 -0500
Date: Mon, 10 Feb 2003 21:54:17 -0500
From: Bill Nottingham <notting@redhat.com>
To: Srihari Vijayaraghavan <harisri@telstra.com>
Cc: linux-kernel@vger.kernel.org, harisri@bigpond.com
Subject: Re: 2.5.60 - xscreensaver no go.
Message-ID: <20030211025417.GA23121@apone.devel.redhat.com>
Mail-Followup-To: Srihari Vijayaraghavan <harisri@telstra.com>,
	linux-kernel@vger.kernel.org, harisri@bigpond.com
References: <14122914808b.14808b141229@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14122914808b.14808b141229@bigpond.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srihari Vijayaraghavan (harisri@telstra.com) said: 
> While I can lock the screen fine (in GNOME that is), I can't unlock the 
> screen (xscreen saver says my password is wrong, while it isn't). I had 
> to terminate XFree86 to get back my desktop (bit of a trouble if I had 
> any unsaved work on the desktop I guess).

Your pam_unix is broken. Take the source RPM, look at
pam-0.75-sigchld.patch, change SIG_IGN to SIG_DFL, and rebuild.

Bill
