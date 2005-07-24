Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVGXXrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVGXXrm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 19:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVGXXrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 19:47:42 -0400
Received: from THUNK.ORG ([69.25.196.29]:12984 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261437AbVGXXrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 19:47:36 -0400
Date: Sun, 24 Jul 2005 10:56:08 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paolo Ornati <ornati@fastwebnet.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Lack of Documentation about SA_RESTART...
Message-ID: <20050724145608.GA6132@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@osdl.org>,
	Paolo Ornati <ornati@fastwebnet.it>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050711123237.787dfcde@localhost> <20050711143427.GC14529@thunk.org> <Pine.LNX.4.58.0507231723270.6074@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507231723270.6074@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2005 at 05:30:42PM -0700, Linus Torvalds wrote:
> On Mon, 11 Jul 2005, Theodore Ts'o wrote:
> > 
> > According to the Single Unix Specification V3, all functions that
> > return EINTR are supposed to restart if a process receives a signal
> > where signal handler has been installed with the SA_RESTART flag.  
> 
> That can't be right.
> 
> Some operations, like "select()" and "pause()" always return EINTR, and 
> indeed, real applications will break if you always restart. Restarting a 
> pause() would be nonsensical.

The spect says "unless otherwise specified".  The description for
pause() states that the process will sleep until receiving a signal
that terminates the process or causes it to call signal-handling
function.  That would presumably count as an "otherwise specified".

						- Ted
