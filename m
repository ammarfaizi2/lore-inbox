Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbUAAVss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 16:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265394AbUAAVoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 16:44:54 -0500
Received: from codepoet.org ([166.70.99.138]:42185 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S265059AbUAAVlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 16:41:18 -0500
Date: Thu, 1 Jan 2004 14:40:51 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andrew Morton <akpm@osdl.org>, Neale Banks <neale@lowendale.com.au>,
       paul@clubi.ie, linux-kernel@vger.kernel.org
Subject: Re: chmod of active swap file blocks
Message-ID: <20040101214051.GA19390@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@osdl.org>,
	Neale Banks <neale@lowendale.com.au>, paul@clubi.ie,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0312291719160.16956@fogarty.jakma.org> <Pine.LNX.4.05.10401011905310.31562-100000@marina.lowendale.com.au> <20040101021241.31830e30.akpm@osdl.org> <20040101151027.A2411@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040101151027.A2411@pclin040.win.tue.nl>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jan 01, 2004 at 03:10:27PM +0100, Andries Brouwer wrote:
> On Thu, Jan 01, 2004 at 02:12:41AM -0800, Andrew Morton wrote:
> > Neale Banks <neale@lowendale.com.au> wrote:
> > >
> > > How much of the original problem goes away if swapon(8) were to refuse to
> > >  activate a file/device which has ownership/mode which it doesn't like?
> > 
> > I think swapon(8) should at least warn when the swapfile has inappropriate
> > permissions.  It's an obvious and outright security hole.
> 
> swapon had this warning for a while, but that generated lots of complaints.
> Now this message is printed only when the -v (verbose) flag is given.

Perhaps swapon should automagically do a chmod and chown on all
swapfiles, unless specifically asked to be wildly insecure
(perhaps with a -W option -- wildly insecure swapfile permissions
are considered acceptable)....

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
