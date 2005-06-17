Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVFQNXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVFQNXh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 09:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVFQNXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 09:23:37 -0400
Received: from 76.80-203-227.nextgentel.com ([80.203.227.76]:2534 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S261966AbVFQNX0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 09:23:26 -0400
To: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Cc: Patrick McFarland <pmcfarland@downeast.net>,
       "Richard B. Johnson" <linux-os@analogic.com>,
       Lukasz Stelmach <stlman@poczta.fm>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
References: <yw1xslzl8g1q.fsf@ford.inprovide.com>
	<200506162118.18470.pmcfarland@downeast.net>
	<yw1xekb1xuk9.fsf@ford.inprovide.com>
	<200506170450.12943.pmcfarland@downeast.net>
	<20050617130914.GB23488@csclub.uwaterloo.ca>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Fri, 17 Jun 2005 15:23:17 +0200
In-Reply-To: <20050617130914.GB23488@csclub.uwaterloo.ca> (Lennart
 Sorensen's message of "Fri, 17 Jun 2005 09:09:14 -0400")
Message-ID: <yw1xy899unga.fsf@ford.inprovide.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lsorense@csclub.uwaterloo.ca (Lennart Sorensen) writes:
> You have probably slightly misunderstood UTF8 at least.  UTF8 tries very
> hard to make sure you can't mistake the characters for ascii, so it
> makes the first byte contains some 1's follwed by one zero.  The number
> of 1's indicates how many bytes the character contains, after the 0 the
> remaining bits is used to store bits for the character.  The remaining
> bytes are all 10xxxxxx which stores another 6 bites of the character code.
> One is required to use the shortest form of utf8 that can store the
> character you are encoding.

Some characters can be encoded in several equally shortest ways.  For
instance, characters with multiple diacritics can have these applied
in different orders.  One of these is designated the canonical
encoding, and should be used in favor of the others.  Those things,
among others, are what makes unicode difficult to deal with.

-- 
Måns Rullgård
mru@inprovide.com
