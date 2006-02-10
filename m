Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWBJTeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWBJTeM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 14:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWBJTeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 14:34:12 -0500
Received: from mail1.kontent.de ([81.88.34.36]:8874 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1751316AbWBJTeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 14:34:11 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Date: Fri, 10 Feb 2006 20:34:06 +0100
User-Agent: KMail/1.8
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com
References: <20060209071832.10500.qmail@science.horizon.com> <43ECDD9B.7090709@yahoo.com.au> <Pine.LNX.4.64.0602101056130.19172@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602101056130.19172@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602102034.07531.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 10. Februar 2006 20:05 schrieb Linus Torvalds:
> So we may have different expectations, because we've seen different 
> patterns. Me, I've seen the "events are huge, and you stagger them", so 
> that the previous event has time to flow out to disk while you generate 
> the next one. There, MS_ASYNC starting IO is _wrong_, because the scale of 
> the event is just huge, so trying to push it through the IO subsystem asap 
> just makes everything suck.

Isn't the benefit of starting writing immediately greater the smaller
the area in question? If so, couldn't a heuristic be found to decide whether
to initiate IO at once?

	Oliver
