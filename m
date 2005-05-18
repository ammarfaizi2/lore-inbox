Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVEREat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVEREat (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 00:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVEREaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 00:30:46 -0400
Received: from graphe.net ([209.204.138.32]:12050 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262081AbVERE2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 00:28:00 -0400
Date: Tue, 17 May 2005 21:27:48 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: "David S. Miller" <davem@davemloft.net>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       shai@scalex86.org
Subject: Re: [PATCH] NUMA aware allocation of transmit and receive buffers
 for e1000
In-Reply-To: <20050517.195703.104034854.davem@davemloft.net>
Message-ID: <Pine.LNX.4.62.0505172125210.22920@graphe.net>
References: <Pine.LNX.4.62.0505171854490.20408@graphe.net>
 <20050517190343.2e57fdd7.akpm@osdl.org> <Pine.LNX.4.62.0505171941340.21153@graphe.net>
 <20050517.195703.104034854.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2005, David S. Miller wrote:

> > Because physically contiguous memory is usually better than virtually 
> > contiguous memory? Any reason that physically contiguous memory will 
> > break the driver?
> 
> The issue is whether size can end up being too large for
> kmalloc() to satisfy, whereas vmalloc() would be able to
> handle it.

Oww.. We need a NUMA aware vmalloc for this?  
