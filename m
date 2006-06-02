Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWFBIP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWFBIP4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 04:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWFBIPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 04:15:55 -0400
Received: from baikonur.stro.at ([213.239.196.228]:61102 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S1751311AbWFBIPz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 04:15:55 -0400
Date: Fri, 2 Jun 2006 10:14:16 +0200
From: maximilian attems <maks@sternwelten.at>
To: linux-kernel@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, klibc list <klibc@zytor.com>
Subject: Re: [PATCH] klibc
Message-ID: <20060602081416.GA11358@nancy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447F4CDB.2060000@zytor.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 June 2006, H. Peter Anvin wrote:
> Brian F. G. Bidulock wrote:
> > On Thu, 01 Jun 2006, Bob Picco wrote:
> >>  
> >> -#if !defined(__x86_64__) && !defined(__ia64__) && !defined(__sparc_v9__)
> >> +#if !defined(__x86_64__) && !defined(__ia64__) && !defined(__sparc_v9__) && \
> >> +	!defined(__powerpc64__)
> > 
> > Why not just !defined(__LP64__) ?
> 
> _BITSIZE == 64 is really the right formula... if I remember correctly, there were some 
> 64-bit platforms (Alpha?) which didn't conform, though.  I will look at this later today.
> 
> 	-hpa

indeed aboves line contains an mistake by an earlier patch of mine.

-#if !defined(__x86_64__) && !defined(__ia64__) && !defined(__sparc_v9__)
+#if !defined(__x86_64__) && !defined(__ia64__) && !defined(__arch64__)

is atm needed to get statfs right on sparc.

-- 
maks
