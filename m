Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161353AbWAST2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161353AbWAST2K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161354AbWAST2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:28:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56547 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161353AbWAST2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:28:08 -0500
Date: Thu, 19 Jan 2006 14:26:54 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [patch] halt_on_oops command line option
Message-ID: <20060119192654.GL21663@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, davej@codemonkey.org.uk,
	linux-kernel@vger.kernel.org
References: <20060118232255.3814001b.akpm@osdl.org> <20060119073951.GC21663@redhat.com> <20060118235958.6b466a86.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118235958.6b466a86.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 11:59:58PM -0800, Andrew Morton wrote:
 > Dave Jones <davej@redhat.com> wrote:
 > >
 > > On Wed, Jan 18, 2006 at 11:22:55PM -0800, Andrew Morton wrote:
 > >  > 
 > >  > How's this look?
 > >  > Attempt to fix the problem wherein people's oops reports scroll off the screen
 > >  > due to repeated oopsing or to oopses on other CPUs.
 > >  > 
 > >  > If this happens the user can reboot with the `halt_on_oops' option.  It will
 > >  > allow the first oopsing CPU to print an oops record just a single time.  Second
 > >  > oopsing attempts, or oopses on other CPUs will cause those CPUs to enter a
 > >  > tight loop.
 > > 
 > > seems a bit aggressive for UP.  Now if my sound driver oopses, I don't
 > > just lose sound, I lock up.  (That's why I made it a pause, not a halt
 > > in my earlier patch).
 > > 
 > 
 > Well I'm assuming people would only enable the option if they are
 > experiencing persistently-scrolling-off oopses.

For this to be useful for me, I'd want it always on.  The majority of
oopses our users hit are one offs, and they don't usually know when
they're going to get an oops ;-)

 > We could make the boot option be number-of-seconds-to-pause I guess.  Do
 > you think it's really worth it?

Beats locking up indefinitly on UP.

		Dave

