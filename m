Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWHNOkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWHNOkr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 10:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWHNOkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 10:40:47 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:39630 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932440AbWHNOkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 10:40:46 -0400
Date: Tue, 15 Aug 2006 00:38:42 +1000
From: Anton Blanchard <anton@samba.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Jan-Bernd Themann <ossthema@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [PATCH 1/6] ehea: interface to network stack
Message-ID: <20060814143842.GM479@krispykreme>
References: <44D99EFC.3000105@de.ibm.com> <20060811205624.GE479@krispykreme> <20060814112656.GC10164@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060814112656.GC10164@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is a conditional cheaper than a divide?  In case of a misprediction I
> would assume it to be significantly slower and I don't know the ratio
> of mispredictions for this branch.

A quick scan of the web shows 40 cycles for athlon64 idiv, and its
similarly slow on many other cpus. Even assuming you mispredict every
branch its going to be a win.

Anton
