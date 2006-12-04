Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937143AbWLDQ4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937143AbWLDQ4A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937148AbWLDQ4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:56:00 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:33543 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937143AbWLDQz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:55:59 -0500
Date: Mon, 4 Dec 2006 08:55:39 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Eric Dumazet <dada1@cosmosbay.com>
cc: Andrew Morton <akpm@osdl.org>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SLAB : use a multiply instead of a divide in obj_to_index()
In-Reply-To: <200612041741.51846.dada1@cosmosbay.com>
Message-ID: <Pine.LNX.4.64.0612040852250.31485@schroedinger.engr.sgi.com>
References: <4564C28B.30604@redhat.com> <4573B8DE.20205@redhat.com>
 <20061203222816.aaef93a3.akpm@osdl.org> <200612041741.51846.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006, Eric Dumazet wrote:

> Doing some math, we can use a reciprocal multiplication instead of a divide.

Could you generalize the reciprocal thingy so that the division 
can be used from other parts of the kernel as well? It would be useful to 
separately get some cycle counts on a regular division compared with your 
division. If that shows benefit then we may think about using it in the 
kernel. I am a bit surprised that this is still an issue on modern cpus.

