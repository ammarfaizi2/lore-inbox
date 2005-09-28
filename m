Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbVI1DrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVI1DrB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 23:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVI1DrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 23:47:00 -0400
Received: from newpeace.netnation.com ([204.174.223.7]:27558 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id S1751171AbVI1DrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 23:47:00 -0400
Date: Tue, 27 Sep 2005 20:47:00 -0700
From: Simon Kirby <sim@netnation.com>
To: Philippe Troin <phil@fifi.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strangeness with signals
Message-ID: <20050928034659.GA27953@netnation.com>
References: <20050927232034.GC6833@netnation.com> <87hdc6htur.fsf@ceramic.fifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87hdc6htur.fsf@ceramic.fifi.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 06:19:24PM -0700, Philippe Troin wrote:

> The SIGWINCH and SIGCHLD signals are not generated if their
> disposition is set to SIG_DFL.  I believe SIGCONT and SIGURG also
> behave similarly.  If you want to see them from your application, you
> have to establish a (potentially empty) signal handler.

Ok, and this is what I did in the example; however, is it expected that
it does not help to set a handler in sa_handler and call sigaction()?
In fact, it does not matter what sa_handler is set to (it can still be
SIG_IGN), but sa_sigaction must point to a valid handler.

Simon-
