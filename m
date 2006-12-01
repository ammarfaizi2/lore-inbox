Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031702AbWLAUmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031702AbWLAUmP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 15:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031765AbWLAUmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 15:42:15 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:41274 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1031702AbWLAUmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 15:42:14 -0500
Message-ID: <457093C5.1040501@cfl.rr.com>
Date: Fri, 01 Dec 2006 15:42:45 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Matt Garman <matthew.garman@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: What happened to CONFIG_TCP_NAGLE_OFF?
References: <bdd6985b0611281405j3e731e3xc7973c0365428663@mail.gmail.com> <456DE85F.50806@cfl.rr.com> <bdd6985b0611300921u1a88f410vdaf9051c220719e1@mail.gmail.com> <456F34BE.5050303@cfl.rr.com> <20061201000030.1d8ba600@localhost.localdomain>
In-Reply-To: <20061201000030.1d8ba600@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Dec 2006 20:42:34.0573 (UTC) FILETIME=[3ADEC7D0:01C71589]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14848.000
X-TM-AS-Result: No--8.698300-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> No it was general purpose. It fixes some extremely bad behaviour in TCP
> with congestion well beyond the "telnet" behaviour.

Saying it is general purpose demeans it.  Nagle was created specifically 
to deal with the bad behavior that results from IO patterns like those 
created by telnet.  Obviously other applications can exhibit those same 
patterns.  Those that do not, have no need for nagle, so they can 
benefit from turning it off.

> UDP is rarely appropriate because it has no congestion control. There are
> more appropriate protocols but they are rarely implemented so TCP
> generally gets used.

UDP is highly appropriate because the congestion controls and other 
features of TCP are not required for this type of data, and in fact, 
tend to muck things up.  That is why the application needs to implement 
its own congestion, sequencing, retransmit and connect/disconnect 
controls; because the way TCP handles them is not good for this 
application.

People often use TCP because it is easier, but not optimal.


