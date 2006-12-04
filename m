Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937256AbWLDSoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937256AbWLDSoP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 13:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937257AbWLDSoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 13:44:15 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:18306 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S937256AbWLDSoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 13:44:14 -0500
Date: Mon, 4 Dec 2006 19:44:13 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Aucoin <Aucoin@Houston.RR.com>
cc: "'Horst H. von Brand'" <vonbrand@inf.utfsm.cl>,
       "'Kyle Moffett'" <mrmacman_g4@mac.com>,
       "'Andrew Morton'" <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: RE: la la la la ... swappiness
In-Reply-To: <200612041749.kB4HnDNw008901@ms-smtp-02.texas.rr.com>
Message-ID: <Pine.LNX.4.63.0612041932360.23702@gockel.physik3.uni-rostock.de>
References: <200612041749.kB4HnDNw008901@ms-smtp-02.texas.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006, Aucoin wrote:

> > From: Horst H. von Brand [mailto:vonbrand@inf.utfsm.cl]
> > That means that there isn't a need for that memory at all (and so they
> 
> In the current isolated non-production, not actually bearing a load test
> case yes. But if I can't get it to not swap on an idle system I have no hope
> of avoiding OOM on a loaded system.

I don't think that assumption is correct. If you have no load on your 
system and the pages in the shared application cache are not actually 
touched, it is perfectly reasonable for the kernel to push out these 
unused pages to swap space to have even more RAM available (e.g. for 
caching the pages more recently accessed by the tar and patch commands). 

I believe your OOM problem is not connected to these observations. There 
might be a problem in the handling of OOM situations in Linux. But before 
coming to that conclusion, I would suggest trying your simulated software 
upgrade scenario with plenty of swap space available and without playing
any tricks with MM settings.

Tim
