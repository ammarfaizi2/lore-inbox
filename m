Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbTDOMtd (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 08:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbTDOMtd 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 08:49:33 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:4365 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S261358AbTDOMtc (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 08:49:32 -0400
Date: Tue, 15 Apr 2003 15:01:09 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Jens Axboe <axboe@suse.de>
cc: Duncan Sands <baldrick@wanadoo.fr>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUGed to death
In-Reply-To: <20030415123134.GM9776@suse.de>
Message-ID: <Pine.LNX.4.44.0304151453320.12110-100000@serv>
References: <80690000.1050351598@flay> <200304151401.00704.baldrick@wanadoo.fr>
 <20030415123134.GM9776@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 15 Apr 2003, Jens Axboe wrote:

> > What happens if you just turn BUG_ON into "do {} while (0)"?
> 
> If you do that, you must audit every single BUG_ON to make sure the
> expression doesn't have any side effects.
> 
> 	BUG_ON(do_the_good_stuff());

This should avoid the problem:

#define BUG_ON(cond) do { if (cond); } while (0)

bye, Roman

