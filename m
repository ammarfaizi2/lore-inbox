Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVELJOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVELJOi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 05:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVELJOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 05:14:38 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:60076 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261368AbVELJK7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 05:10:59 -0400
Message-ID: <42831D97.8000600@freenet.de>
Date: Thu, 12 May 2005 11:10:47 +0200
From: Carsten Otte <cotte@freenet.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 0/5] add execute in place support
References: <428216DF.8070205@de.ibm.com> <1115828389.16187.544.camel@hades.cambridge.redhat.com> <42823450.8030007@freenet.de> <20050512085741.GA16361@wohnheim.fh-wedel.de>
In-Reply-To: <20050512085741.GA16361@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:

> In principle, both the block device abstraction and the mtd
>
>abstraction fit your bill.  But jffs2 doesn't, so no in-kernel fs
>could make use of a xip-aware mtd abstraction.
>  
>
True. In fact I thought about an mtd device driver for our dcss
segments instead of a block device driver. A filesystem on top
of mtd that implements get_xip_page does the very same job.
But after I decided to build on the ext family, I discarded that
idea because ext does use the block device interface.


