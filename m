Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272901AbTHNQxw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 12:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272932AbTHNQxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 12:53:52 -0400
Received: from mailhost.NMT.EDU ([129.138.4.52]:63143 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id S272901AbTHNQxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 12:53:38 -0400
Date: Thu, 14 Aug 2003 10:53:20 -0600
From: Val Henson <val@nmt.edu>
To: Matt Mackall <mpm@selenic.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, James Morris <jmorris@intercode.com.au>,
       Jamie Lokier <jamie@shareable.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030814165320.GA2839@speare5-1-14>
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813040614.GP31810@waste.org>
User-Agent: Mutt/1.4.1i
X-Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 11:06:14PM -0500, Matt Mackall wrote:
> On Tue, Aug 12, 2003 at 11:20:38PM -0400, Theodore Ts'o wrote:
> 
> > The real issue is discarding information.  By folding, we hide
> > information about the output of the SHA hash that will hopefully deny
> > information that a Very Sophisticated Attacker (say, at the level of a
> > certain agency that designed the SHA algorithm) that might make it
> > easier for them to attack the SHA algorithm.
> 
> I'll buy that. However simply dropping the data would serve this
> purpose better. As would hashing less than the entire pool on each
> read. 

I agree.  Throwing away 80 bits of the 160 bit output is much better
than folding the two halves together.  In all the cases we've
discussed where folding might improve matters, throwing away half the
output would be even better.

-VAL
