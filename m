Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265958AbUGOD6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265958AbUGOD6L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 23:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265964AbUGOD6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 23:58:08 -0400
Received: from palrel10.hp.com ([156.153.255.245]:49075 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265958AbUGOD6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 23:58:00 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16630.196.880937.911232@napali.hpl.hp.com>
Date: Wed, 14 Jul 2004 20:57:56 -0700
To: john stultz <johnstul@us.ibm.com>
Cc: David Mosberger <davidm@hpl.hp.com>, Christoph Lameter <clameter@sgi.com>,
       george anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>, ia64 <linux-ia64@vger.kernel.org>
Subject: Re: gettimeofday nanoseconds patch (makes it possible for the
	posix-timer functions to return higher accuracy)
In-Reply-To: <1089855319.1388.295.camel@cog.beaverton.ibm.com>
References: <Pine.LNX.4.58.0407140940260.14704@schroedinger.engr.sgi.com>
	<1089835776.1388.216.camel@cog.beaverton.ibm.com>
	<Pine.LNX.4.58.0407141323530.15874@schroedinger.engr.sgi.com>
	<1089839740.1388.230.camel@cog.beaverton.ibm.com>
	<Pine.LNX.4.58.0407141703360.17055@schroedinger.engr.sgi.com>
	<1089852486.1388.256.camel@cog.beaverton.ibm.com>
	<16629.56037.120532.779793@napali.hpl.hp.com>
	<1089855319.1388.295.camel@cog.beaverton.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 14 Jul 2004 18:35:20 -0700, john stultz <johnstul@us.ibm.com> said:

  john> On Wed, 2004-07-14 at 18:16, David Mosberger wrote:
  >> >>>>> On Wed, 14 Jul 2004 17:48:06 -0700, john stultz
  >> <johnstul@us.ibm.com> said:

  >>  The existing time-interpolator code for ia64 never lets time go
  >> backwards (in the absence of a settimeofday(), of course).  There
  >> is no need to special-case NTP.

  John> I guess I don't understand then, from my looking over it I
  John> didn't see where the time_interpolator_get_offset() is scaled
  John> back when NTP is slewing the clock.

Are you looking at Christoph's code?  My explanation applies to the
old interpolation-code...

	--david
