Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266466AbUG2AU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266466AbUG2AU2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266409AbUG2ASX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:18:23 -0400
Received: from holomorphy.com ([207.189.100.168]:6032 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267377AbUG2AOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:14:55 -0400
Date: Wed, 28 Jul 2004 17:14:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, kaos@ocs.com.au,
       chrisw@osdl.org, jbarnes@engr.sgi.com, kiran@in.ibm.com,
       dipankar@in.ibm.com
Subject: Re: [RFC] Lock free fd lookup
Message-ID: <20040729001444.GL2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	kaos@ocs.com.au, chrisw@osdl.org, jbarnes@engr.sgi.com,
	kiran@in.ibm.com, dipankar@in.ibm.com
References: <1090091875.1232.456.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090091875.1232.456.camel@cube>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
>> Writer vs. writer starvation on NUMA is a lot harder.  I don't know
>> of any algorithm that handles lists with lots of concurrent updates
>> and also scales well on large cpus, unless the underlying hardware
>> is fair in its handling of exclusive cache lines.

On Sat, Jul 17, 2004 at 03:17:55PM -0400, Albert Cahalan wrote:
> How about MCS (Mellor-Crummey and Scott) locks?
> Linux code:
> http://oss.software.ibm.com/linux/patches/?patch_id=218
> Something supposedly better:
> http://user.it.uu.se/~zoranr/rh_lock/
> Scott's list of 11 scalable synchronization algorithms:
> http://www.cs.rochester.edu/u/scott/synchronization/pseudocode/ss.html
> Scott's collection of papers and so on:
> http://www.cs.rochester.edu/u/scott/synchronization/
> Simply asking Scott might be a wise move. He'd likely know of anything
> else that might fit the requirements. That's scott at cs.rochester.edu

Did anyone follow up with Scott on this?


-- wli
