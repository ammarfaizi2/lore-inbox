Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVAGWiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVAGWiY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVAGWcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:32:42 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:55235 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S261678AbVAGW0m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:26:42 -0500
Message-Id: <200501072226.j07MQX1E019627@localhost.localdomain>
To: Christoph Hellwig <hch@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       arjanv@redhat.com, mingo@elte.hu, chrisw@osdl.org,
       alan@lxorguk.ukuu.org.uk, joq@io.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Fri, 07 Jan 2005 22:10:59 GMT."
             <20050107221059.GA17392@infradead.org> 
Date: Fri, 07 Jan 2005 17:26:32 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.197.185.179] at Fri, 7 Jan 2005 16:26:34 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>So to make forward progress I'd like the audio people to confirm whether
>the mlock bits in 2.6.9+ do help that half of their requirement first

it does, although it would be nicer to not have two separate
components to administering the usability of realtime applications.

>(and if not find a way to fix it) and then tackle the scheduling part.
>For that one I really wonder whether the combination of the now actually
>working nicelevels (see Mingo's post) and a simple wrapper for the really
>high requirements cases doesn't work.

Jack already posted results: the nice levels are massively inferior as
they currently stand.

The wrapper is incredibly inconvenient for applications: when you use
JACK, start clients would require a different command depending on
whether JACK is using RT mode or not. That is extremely inelegant, and
its why we've developed these solutions (caps+jackstart for 2.4,
"realtime" LSM for 2.6).

--p

