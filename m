Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264133AbTDWRBf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264139AbTDWRBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:01:35 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:32779 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264133AbTDWRBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:01:33 -0400
Date: Wed, 23 Apr 2003 18:13:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stuffed Crust <pizza@shaftnet.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.5.68] [BUG #18] Add Synaptics touchpad tweaking to psmouse driver
Message-ID: <20030423181339.A2904@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stuffed Crust <pizza@shaftnet.org>, linux-kernel@vger.kernel.org
References: <20030422024628.GA8906@shaftnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030422024628.GA8906@shaftnet.org>; from pizza@shaftnet.org on Mon, Apr 21, 2003 at 10:46:28PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 10:46:28PM -0400, Stuffed Crust wrote:
> One of the side-effects of the new input layer is that the old usermode 
> tools for manipulating the touchpad configuration don't work any more.
> 
> Most importantly, the ability to disable the tap-to-click "feature".
> And this has been long-recognized, as bug #18.  :)
> 
> So, here's my crack at scratching this itch.  it defaults to disabling 
> the tap-to-click, but there's a module parameter to re-enable it.
> 
> I started writing this from the perspective of a full-native synaptics
> driver, using the absolute mode of operation, which will let us do all
> sorts of yummy things like corner taps and virtual scroll wheels and
> sensitivity and whatnot... Anyone else working on this, before I wade
> further in?
> 
> All of the new code is wrapped in #ifdef SYNAPTICS.

This is messy as hell - what about copying psmouse.c, remove all
that code not relevant to the touchpad and make it a driver of it's
own?

