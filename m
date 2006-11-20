Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934113AbWKTMTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934113AbWKTMTv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 07:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934115AbWKTMTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 07:19:51 -0500
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:20622 "EHLO
	excu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S934113AbWKTMTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 07:19:50 -0500
X-AuditID: c606310c-aae73bb000006f35-62-45619dc8c129 
Date: Mon, 20 Nov 2006 12:20:03 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Francis Moreau <francis.moro@gmail.com>
cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org
Subject: Re: Re : vm: weird behaviour when munmapping
In-Reply-To: <38b2ab8a0611200330w17a84994ne3a0eed11ae4485c@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611201213460.11655@blonde.wat.veritas.com>
References: <38b2ab8a0611171301pe16229ch441ec24c538b1998@mail.gmail.com> 
 <Pine.LNX.4.64.0611181340220.7193@blonde.wat.veritas.com>
 <38b2ab8a0611200330w17a84994ne3a0eed11ae4485c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 20 Nov 2006 12:19:45.0838 (UTC) FILETIME=[2A5BE4E0:01C70C9E]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006, Francis Moreau wrote:
> 
> I end up to see "open(B), close(B)" sequence when unmapping a part of
> the dumb device that I found strange. I think that "open(A') close(B)"
> can give more information to the driver and reflect that B is unmapped
> and A' is still mapped and becomes the new mapped area.
> But it's may be just me...

I think I do now get your point.  But your way round doesn't really
reflect what's going on either: the range A' was already open and now
you open it again.  Until there's some driver actually needing more
sophisticated treatment, let's just leave it the simple way it is.

Hugh
