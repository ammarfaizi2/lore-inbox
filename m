Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbTITCX4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 22:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbTITCX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 22:23:56 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:64261 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S261263AbTITCXz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 22:23:55 -0400
Date: Sat, 20 Sep 2003 03:23:53 +0100
From: John Levon <levon@movementarian.org>
To: "Villacis, Juan" <juan.villacis@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.x] additional kernel event notifications
Message-ID: <20030920022352.GA73232@compsoc.man.ac.uk>
References: <7F740D512C7C1046AB53446D372001732DEC73@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D372001732DEC73@scsmsx402.sc.intel.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1A0XPd-0000Tr-5f*MceCqndSgMo*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 05:57:40PM -0700, Villacis, Juan wrote:

> both tools capture performance data, but Oprofile was designed with
> aggregation in mind whereas VTune was designed to collect all the data
> and then post-process it.

It would help a huge amount if you explained how you do :

EIP -> java source line / symbol

This is the exact transformation that oprofile *doesn't* do, and I never
managed to get a clear explanation of what you need and why for that to
happen.

In particular, your userspace must be doing some sort of communication
with the running Java VM, and the question remains open as to whether
it's possible to do that in an oprofile manner instead of a VTune 2.4 /
OProfile 2.4 manner.

I still suspect we have significant amounts of code that can be merged
between us. This would be a significant benefit to the poor saps such as
akpm who have to care about the kernel as a whole.

You also mentioned performance issues with the current OProfile code -
have we discussed the new design at all (basically: keep task structs
hanging around, remove the horrific buffer_sem)

regards
john

-- 
Khendon's Law:
If the same point is made twice by the same person, the thread is over.
