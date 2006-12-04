Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937062AbWLDSP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937062AbWLDSP5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 13:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937068AbWLDSP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 13:15:57 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:42122 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937062AbWLDSP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 13:15:56 -0500
Date: Mon, 4 Dec 2006 10:15:21 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, Aucoin@houston.rr.com,
       "'Kyle Moffett'" <mrmacman_g4@mac.com>,
       "'Tim Schmielau'" <tim@physik3.uni-rostock.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, dcn@sgi.com
Subject: Re: la la la la ... swappiness
In-Reply-To: <20061204100656.793d8d6a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612041012010.32156@schroedinger.engr.sgi.com>
References: <200612041439.kB4EdGFn025092@ms-smtp-03.texas.rr.com>
 <200612041707.kB4H7Mnh020665@laptop13.inf.utfsm.cl> <20061204100656.793d8d6a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006, Andrew Morton wrote:

> but that's rather dumb.  Better would be to remove mlocked pages from the
> LRU.

Could we generalize the removal of sections of a zone from the LRU? I 
believe this would help various buffer allocation schemes. We have some 
issues with heavy LRU scans if large buffers are allocated on some 
nodes.
