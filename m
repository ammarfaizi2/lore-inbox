Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269745AbUINUSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269745AbUINUSM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269767AbUINUP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:15:57 -0400
Received: from holomorphy.com ([207.189.100.168]:14742 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269745AbUINUMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 16:12:07 -0400
Date: Tue, 14 Sep 2004 13:11:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: offtopic: how to break huge patch into smaller independent patches?
Message-ID: <20040914201157.GJ9106@holomorphy.com>
References: <41474B15.8040302@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41474B15.8040302@nortelnetworks.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 01:48:37PM -0600, Chris Friesen wrote:
> Its kind of offtopic, but I hoped that someone might have some pointers 
> since the kernel developers deal with so many patches.
> I've been given a massive kernel patch that makes a whole bunch of 
> conceptually independent changes.
> Does anyone have any advice on how to break it up into independent patches?

It's hard work. It's sometimes even harder than writing the patch
itself. To handle this, I would:

(a) identify the conceptually independent changes
(b) rewrite the conceptually independent changes separately in series
(c) look for the results of (b) that are too large, and try to find
	some way to represent them as a series conceptually independent
	changes.
(d) if (c) returned a nonzero number of results, recurse to (b)

Yes, this means you have to rewrite the stuff altogether. This is not
quite as hard as it sounds, as you can largely "discover" what the
rewrites should be by filtering changes. But it's still relatively hard.

Identifying conceptually independent changes has no universal rules, so
that may also be hard.


-- wli
