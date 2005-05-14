Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262760AbVENNlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbVENNlt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 09:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbVENNl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 09:41:29 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:25483 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S262760AbVENNlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 09:41:22 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: Y2K-like bug to hit Linux computers! - Info of the day
To: "Srinivas G." <srinivasg@esntechnologies.co.in>,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Sat, 14 May 2005 15:41:52 +0200
References: <43GQ7-5qy-5@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DWwtu-0000mS-AY@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srinivas G. <srinivasg@esntechnologies.co.in> wrote:

> But what about the present? Many applications running on Linux could
> soon be making calculations for dates 30 years away -- say, for mortgage
> and insurance calculations -- and could start giving out error messages
> well before D-day. The problem could be widespread because more and more
> corporates today are migrating to Linux because of the better security
> it offers.

time_t is for systems times only, and it is not to be manipulated directly.
If you'd do that, you'll miss leap seconds and have additional leap years.
Besides that, it's not portable to different EPOCHs.

Therefore, apllications MUST use their own time types.
-- 
            A. Top posters
            Q. What's the most annoying thing on Usenet?

