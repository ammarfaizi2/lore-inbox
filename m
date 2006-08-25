Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422870AbWHYPvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422870AbWHYPvi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422869AbWHYPvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:51:37 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:38121 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422867AbWHYPve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:51:34 -0400
Date: Fri, 25 Aug 2006 08:51:09 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Indan Zupancic <indan@nul.nu>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/4] VM deadlock prevention -v5
In-Reply-To: <20060825153946.24271.42758.sendpatchset@twins>
Message-ID: <Pine.LNX.4.64.0608250849480.9083@schroedinger.engr.sgi.com>
References: <20060825153946.24271.42758.sendpatchset@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2006, Peter Zijlstra wrote:

> The basic premises is that network sockets serving the VM need undisturbed
> functionality in the face of severe memory shortage.
> 
> This patch-set provides the framework to provide this.

Hmmm.. Is it not possible to avoid the memory pools by 
guaranteeing that a certain number of page is easily reclaimable?
