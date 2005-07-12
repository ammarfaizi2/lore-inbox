Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVGLDae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVGLDae (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 23:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbVGLDae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 23:30:34 -0400
Received: from tantale.fifi.org ([64.81.251.130]:39561 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S262011AbVGLDab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 23:30:31 -0400
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Paolo Ornati <ornati@fastwebnet.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Lack of Documentation about SA_RESTART...
References: <20050711123237.787dfcde@localhost>
	<20050711143427.GC14529@thunk.org>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 11 Jul 2005 20:30:20 -0700
In-Reply-To: <20050711143427.GC14529@thunk.org>
Message-ID: <87mzos4s6r.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Mon, Jul 11, 2005 at 12:32:37PM +0200, Paolo Ornati wrote:
> > But what I'm looking for is a list of syscalls that are automatically
> > restarted when SA_RESTART is set, and especially in what conditions.
> > 
> > For example: read(), write(), open() are obviously restarted, but even
> > on non-blocking fd?
> > And what about connect() and select() for example?
> > 
> > There are a lot of syscalls that can fail with "EINTR"! What's the
> > advantage of using SA_RESTART if one doesn't know what syscalls are
> > restarted?
> 
> According to the Single Unix Specification V3, all functions that
> return EINTR are supposed to restart if a process receives a signal
> where signal handler has been installed with the SA_RESTART flag.  

Except for select() and poll(), which should always return EINTR even
when interrupted with a SA_RESTART signal.

Phil.
