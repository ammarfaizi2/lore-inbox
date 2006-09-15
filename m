Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWIOSef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWIOSef (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 14:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWIOSef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 14:34:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18614 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932158AbWIOSee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 14:34:34 -0400
Date: Fri, 15 Sep 2006 14:34:32 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108]
Message-ID: <20060915183432.GJ4577@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

On Fri, Sep 15, 2006 at 07:31:48PM +0100, Alan Cox wrote:
> Ar Gwe, 2006-09-15 am 13:08 -0400, ysgrifennodd Frank Ch. Eigler:
Yeah, or something. :-)

> > Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > - where 1000-cycle int3-dispatching overheads too high
> 
> Why are your despatching overheads 1000 cycles ? (and if its due to int3
> why are you using int 3 8))

Smart teams from IBM and Hitachi have been hammering away at this code
for a year or two now, and yet (roughly) here we are.  There have been
experiments involving plopping branches instead of int3's at probe
locations, but this is self-modifying code involving multiple
instructions, and appears to be tricky on SMP/preempt boxes.

- FChE
