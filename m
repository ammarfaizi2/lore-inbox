Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbTIMTh6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 15:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbTIMTh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 15:37:58 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:56978 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261803AbTIMTh5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 15:37:57 -0400
Date: Sat, 13 Sep 2003 20:37:47 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Iker <iker@computer.org>, David Schwartz <davids@webmaster.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [lkml] RE: self piping and context switching
Message-ID: <20030913193747.GF7404@mail.jlokier.co.uk>
References: <MDEHLPKNGKAHNMBLJOLKCECHGIAA.davids@webmaster.com> <03f501c379a2$b14b49b0$3203a8c0@duke> <1063473005.8519.7.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063473005.8519.7.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sad, 2003-09-13 at 03:56, Iker wrote:
> > More specifically, I was wondering if the write to the pipe or the call back
> > into poll involved anything that might prompt the scheduler to replace the
> > thread in this scenario.
> 
> Unless it happens to cause page faults or fill up the pipe nothing in
> paticular.  Sending a message to yourself down a pipe is pretty standard
> in event based programs as a way of turning a signal from asynchronous
> event and thus nuisance to handle into a message.

This "pretty standard" method is the reason Netscape 4.07 hangs on
computers which are too fast: It writes too many events to a pipe
before reading from the pipe, and the pipe fills.

Of course that is a programming error.  Just a reminder to be careful :)

-- Jamie
