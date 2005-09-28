Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbVI1Pef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbVI1Pef (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 11:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbVI1Pef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 11:34:35 -0400
Received: from tantale.fifi.org ([64.81.251.130]:404 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S1750858AbVI1Pef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 11:34:35 -0400
To: Simon Kirby <sim@netnation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strangeness with signals
References: <20050927232034.GC6833@netnation.com>
	<87hdc6htur.fsf@ceramic.fifi.org>
	<20050928034659.GA27953@netnation.com>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 28 Sep 2005 08:30:06 -0700
In-Reply-To: <20050928034659.GA27953@netnation.com>
Message-ID: <873bnp5hxd.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Kirby <sim@netnation.com> writes:

> On Tue, Sep 27, 2005 at 06:19:24PM -0700, Philippe Troin wrote:
> 
> > The SIGWINCH and SIGCHLD signals are not generated if their
> > disposition is set to SIG_DFL.  I believe SIGCONT and SIGURG also
> > behave similarly.  If you want to see them from your application, you
> > have to establish a (potentially empty) signal handler.
> 
> Ok, and this is what I did in the example; however, is it expected that
> it does not help to set a handler in sa_handler and call sigaction()?
> In fact, it does not matter what sa_handler is set to (it can still be
> SIG_IGN), but sa_sigaction must point to a valid handler.

As long as sa_handler (or sa_sigaction) is not SIG_DFL (which is NULL
on linux).

Phil.
