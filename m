Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbVHVUaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbVHVUaL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVHVUaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:30:11 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:17625 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751062AbVHVUaK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:30:10 -0400
Date: Mon, 22 Aug 2005 22:38:05 +0200
To: Guillermo =?iso-8859-1?Q?L=F3pez?= Alejos <glalejos@gmail.com>
Cc: Linh Dang <linhd@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: Environment variables inside the kernel?
Message-ID: <20050822203805.GA29754@aitel.hist.no>
References: <4fec73ca050818084467f04c31@mail.gmail.com> <m2ek8r5hhh.fsf@Douglas-McNaughts-Powerbook.local> <wn5slx75cjs.fsf@linhd-2.ca.nortel.com> <4fec73ca05081811488ec518e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fec73ca05081811488ec518e@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 08:48:04PM +0200, Guillermo López Alejos wrote:
> Whoa!, I did not expect so many replies. Thank you for your answers.
> 
> The thing is that the Computer Architecture area of the University I
> am studying at is developing a parallel filesystem. Currently it works
> as a stand-alone program (this is why it uses resources like
> environment variables), and I have been told to integrate it in the
> Linux kernel.
> 
> I have to justify changes on this filesystem code (like avoiding the
> use of environment variables) to my tutor. In this case I needed to
> find why it is not possible to use environment variables in kernel
> space.
> 
> I was looking for a reference documentation which give a definition of
> environment variables that exclude their use inside the kernel, or,
> simply, I expected to find a design decision to justify this. But I
> think I have enough information with your answers, I will be able to
> elaborate a satisfactory conclusion.
> 
> Excuse me if the topic was so obvious (it was not to me) and thank you again,

It is obvious to someone who knows what the kernel is. A kernel and
a process is very different things.  A comparison to something
different:

A book always have a "page 1".  It is usually only the title, so it
is a nice place for writing some notes as well. 
(similiar to how a process have an environment.)

A library is a big collection of books, (similiar to how the kernel
manages a collection of processes.)  Still, it does not make sense
at all to talk about "page 1 of the library!"  Even if it _is_ useful
to write some library-specific notes somewhere.

The kernel does not have an environment of its own.  It manages all
the processes, and jave equal access all of the environmnts 
(albeit in a hackish way only) for process envirnments are _not_
part of the kernel/process communication interface.  

|1
Helge Hafting

