Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161265AbWHJNil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161265AbWHJNil (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 09:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161268AbWHJNil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 09:38:41 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:60593 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1161265AbWHJNil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 09:38:41 -0400
Message-Id: <44DB532F.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Thu, 10 Aug 2006 15:39:27 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386: annotate the rest of entry.s::nmi
References: <200608100851_MC3-1-C7A8-8B6A@compuserve.com>
In-Reply-To: <200608100851_MC3-1-C7A8-8B6A@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Part of the NMI handler is missing annotations.  Just moving
>> >the RING0_INT_FRAME macro fixes it.  And additional comments
>> >should warn anyone changing this to recheck the annotations.
>> 
>> I have to admit that I can't see the value of this movement; the
>> code sequence in question was left un-annotated intentionally.
>> The point is that the push-es in FIX_STACK() aren't annotated, so
>> things won't be correct at those points anyway.
>
>I have a patch here that adds that, but it won't compile
>because that part of the NMI handler is un-annotated:

But you didn't clarify why you need this piece of code annotated...

Jan
