Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbTFTKiz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 06:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTFTKiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 06:38:55 -0400
Received: from ns.suse.de ([213.95.15.193]:24843 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262737AbTFTKiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 06:38:52 -0400
Date: Fri, 20 Jun 2003 12:52:53 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Fruhwirth Clemens <clemens-dated-1056968093.cf44@endorphin.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Initial Vector Fix for loop.c.
Message-ID: <20030620105253.GA9187@wotan.suse.de>
References: <20030620090612.GA1322@ghanima.endorphin.org.suse.lists.linux.kernel> <p73u1al3xlw.fsf@oldwotan.suse.de> <20030620101452.GA2233@ghanima.endorphin.org> <20030620102455.GC26678@wotan.suse.de> <20030620103538.GA28711@wohnheim.fh-wedel.de> <20030620104953.GD26678@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030620104953.GD26678@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Typo in there.

On Fri, Jun 20, 2003 at 12:49:53PM +0200, Andi Kleen wrote:
> In my opinion it doesn't make much difference. crypto-loop 
> has broken beyond belief[1] IV anyways, so they will
> eventually need to change it. Or just use CBC, which is simpler 
                                            ^^^
											should be ECB of course.
											
> 
> [1] the problem is that it is too predictable. consider block 0,
> which is usually filled with zeros. It also has IV==0. This means
> it it 100% equivalent to CBC and worse even has known plain text.
                           ^^^
						   also ECB here.

-Andi
