Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751804AbWHNGvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbWHNGvS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 02:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbWHNGvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 02:51:18 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:18646 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1751804AbWHNGvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 02:51:17 -0400
Message-Id: <44E039B0.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 14 Aug 2006 08:52:00 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Stas Sergeev" <stsp@aknet.ru>
Cc: "Chuck Ebbert" <76306.1226@compuserve.com>, "Andi Kleen" <ak@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386: annotate the rest of entry.s::nmi
References: <200608100101_MC3-1-C796-F8CA@compuserve.com>
 <44DB0927.76E4.0078.0@novell.com> <44DCC283.7030709@aknet.ru>
In-Reply-To: <44DCC283.7030709@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> even more, as I'm now looking at it, this code seems
>> outright wrong in using iret since that unmasks NMIs - Stas, is
>> your pending adjustment to the 16-bit stack handling going to
>> overcome this?)
>No, it leaves the NMI path almost untouched.
>But what exactly problem do you see with this iret?
>If it unmasks NMI, then it does so for reason, which
>is a return from an NMI handler. What exactly is wrong
>with it?

Oh, yes, you're right, I didn't pay attention to the second do_nmi
call in that path.

Sorry, Jan
