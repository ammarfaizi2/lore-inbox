Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266134AbUAGF02 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 00:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266135AbUAGF02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 00:26:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:47257 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266134AbUAGF01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 00:26:27 -0500
Date: Tue, 6 Jan 2004 21:26:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alex Buell <alex.buell@munted.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/slabinfo reports excessive size-64 objects
Message-Id: <20040106212634.35bc41b5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401070111250.27290@slut.local.munted.org.uk>
References: <Pine.LNX.4.58.0401070111250.27290@slut.local.munted.org.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Buell <alex.buell@munted.org.uk> wrote:
>
> Both of my 2.4.23 boxes reports excessive size-64 objects 
> 
> 1) on my 512MB box, it's  3176370 3176442     64 53838 53838    1 
> 2) on my 128MB box, it's  1223329 1223365     64 20735 20735	1
> 
> Is this really normal? Both boxes have been up for 2 days, but the 128MB
> box is starting to show signs of getting slower and slower the more the
> size-64 cache increases.

It looks unusual.  Are you running any less popular device drivers or
networking configurations?

We had a couple of ext3/htree leaks which did this in 2.6.  Nothing else
comes to mind.

