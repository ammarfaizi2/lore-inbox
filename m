Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269421AbUJLDjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269421AbUJLDjj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 23:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269422AbUJLDji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 23:39:38 -0400
Received: from elektroni.ee.tut.fi ([130.230.131.11]:640 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP id S269421AbUJLDjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 23:39:36 -0400
Date: Tue, 12 Oct 2004 06:39:34 +0300
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: Roland McGrath <roland@redhat.com>
Cc: Joshua Kwan <joshk@triplehelix.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Weirdness with suspending jobs in 2.6.9-rc3
Message-ID: <20041012033934.GA275@elektroni.ee.tut.fi>
Mail-Followup-To: Roland McGrath <roland@redhat.com>,
	Joshua Kwan <joshk@triplehelix.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <20041010211507.GB3316@triplehelix.org> <200410112055.i9BKt5LI031359@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410112055.i9BKt5LI031359@magilla.sf.frob.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 01:55:05PM -0700, Roland McGrath wrote:
> > wait4(-1073750280, NULL, 0, NULL)       = -1 ECHILD (No child processes)
> 
> That is a clearly bogus argument.

Hi. I see it too:

wait4(-1073750328, NULL, 0, NULL)       = -1 ECHILD (No child processes)

But the whole problem goes away if I switch CONFIG_REGPARM off. To reproduce
it needs CONFIG_REGPARM=y.

Hope this helps.
