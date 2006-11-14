Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966366AbWKNV2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966366AbWKNV2P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966367AbWKNV2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:28:15 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58534 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S966366AbWKNV2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:28:14 -0500
Date: Tue, 14 Nov 2006 13:28:04 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Suleiman Souhlal <ssouhlal@freebsd.org>
cc: Andi Kleen <ak@suse.de>, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz, Jiri Bohac <jbohac@suse.cz>
Subject: Re: [PATCH 0/2] Make the TSC safe to be used by gettimeofday().
In-Reply-To: <45592497.1080109@FreeBSD.org>
Message-ID: <Pine.LNX.4.64.0611141327020.13469@schroedinger.engr.sgi.com>
References: <455916A5.2030402@FreeBSD.org> <200611140250.57160.ak@suse.de>
 <45592497.1080109@FreeBSD.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006, Suleiman Souhlal wrote:

> I believe that the results returned will always be monotonic, as long as the
> frequency of the TSC does not change from under us (that is, without the
> kernel knowing). This is because we "synchronize" each CPU's vxtime with a
> global time source (HPET) every time we know the TSC rate changes.

TSC frequencies of different clocks coming with multiple 
processors may vary which creates a differential even if they are 
initially synchronized.
