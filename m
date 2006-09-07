Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWIGGoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWIGGoQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 02:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWIGGoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 02:44:16 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:60085 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750819AbWIGGoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 02:44:15 -0400
Date: Thu, 7 Sep 2006 08:43:21 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Madore <david.madore@ens.fr>
cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
In-Reply-To: <20060906222731.GA10675@clipper.ens.fr>
Message-ID: <Pine.LNX.4.61.0609070839220.3853@yvahk01.tjqt.qr>
References: <20060905212643.GA13613@clipper.ens.fr>
 <20060906182531.GA24670@sergelap.austin.ibm.com> <20060906222731.GA10675@clipper.ens.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> In the meantime, so long as you're adding some new capabilities, how
>> about also splitting up a few like CAP_SYS_ADMIN?  Have you looked into
>> it and decided none are really separable, i.e. any subset leads to the
>> ability to get any other subset?
>
>I agree that splitting CAP_SYS_ADMIN might be worth while, but it
>really looks like opening a worm can, so I didn't feel up to the
>challenge there.  It might be a good idea to reserve some bits for
>that possibility, however - I'm not sure how best to proceed.

Split it into read and write options, for a start. This is important in
a sub-"root"-user environment as is currently created with my MultiAdm
LSM, which, due to the broad spectrum CAP_SYS_ADMIN addresses, must
give SYS_ADMIN to the subadmin (to be able to read restricted objects)
and restrict it afterwards in all the LSM hooks (to not write to
restricted objects).

http://lkml.org/lkml/2006/5/1/105
http://lkml.org/lkml/2006/5/1/110 <- important


Jan Engelhardt
-- 
