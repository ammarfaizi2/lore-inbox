Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbTELNKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 09:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbTELNKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 09:10:41 -0400
Received: from www.wireboard.com ([216.151.155.101]:5291 "EHLO
	varsoon.wireboard.com") by vger.kernel.org with ESMTP
	id S262124AbTELNKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 09:10:39 -0400
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Muli Ben-Yehuda <mulix@mulix.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC]  new syscall to allow notification when arbitrary pids die
References: <3EBC9C62.5010507@nortelnetworks.com>
	<20030510073842.GA31003@actcom.co.il>
	<3EBF144E.7050608@nortelnetworks.com>
	<m3y91cj0vm.fsf@varsoon.wireboard.com>
	<3EBF240A.4050706@nortelnetworks.com>
From: Doug McNaught <doug@mcnaught.org>
Date: 12 May 2003 09:23:12 -0400
In-Reply-To: Chris Friesen's message of "Mon, 12 May 2003 00:33:14 -0400"
Message-ID: <m3smrki9j3.fsf@varsoon.wireboard.com>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortelnetworks.com> writes:

> Doug McNaught wrote:

> > Rather than a new syscall, what about a magic file or device that you
> > can poll()?
> 
> This is definately an option to consider.  The problem that I see with
> this is that when you are trying to monitor large numbers of processes
> you have to worry about running out of file descriptors, and select()
> is no longer as happy.

No reason to have one FD per process monitored.  Just a single FD, to
which you can write() a control string to to add or remove a process
from the list, and for which read() yields a small data record
describing the process event that just happened.  It's a bit plan-9ish
but there's nothing wrong with that...

-Doug
