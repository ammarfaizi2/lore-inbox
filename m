Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266174AbUAGJ66 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 04:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUAGJ65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 04:58:57 -0500
Received: from cpc1-cosh4-5-0-cust84.cos2.cable.ntl.com ([81.96.30.84]:46720
	"EHLO slut.local.munted.org.uk") by vger.kernel.org with ESMTP
	id S266174AbUAGJ6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 04:58:49 -0500
Date: Wed, 7 Jan 2004 09:58:33 +0000 (GMT)
From: Alex Buell <alex.buell@munted.org.uk>
X-X-Sender: alex@slut.local.munted.org.uk
To: Andrew Morton <akpm@osdl.org>
cc: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: /proc/slabinfo reports excessive size-64 objects
In-Reply-To: <20040106212634.35bc41b5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0401070957420.10797@slut.local.munted.org.uk>
References: <Pine.LNX.4.58.0401070111250.27290@slut.local.munted.org.uk>
 <20040106212634.35bc41b5.akpm@osdl.org>
X-no-archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jan 2004, Andrew Morton wrote:

> Alex Buell <alex.buell@munted.org.uk> wrote:
> >
> > Both of my 2.4.23 boxes reports excessive size-64 objects 
> > 
> > 1) on my 512MB box, it's  3176370 3176442     64 53838 53838    1 
> > 2) on my 128MB box, it's  1223329 1223365     64 20735 20735	1
> > 
> > Is this really normal? Both boxes have been up for 2 days, but the 128MB
> > box is starting to show signs of getting slower and slower the more the
> > size-64 cache increases.
> 
> It looks unusual.  Are you running any less popular device drivers or
> networking configurations?
> 
> We had a couple of ext3/htree leaks which did this in 2.6.  Nothing else
> comes to mind.

Yup, it was an ext3/htree leak. I've been given a patch to test. 

-- 
http://www.munted.org.uk

Your mother cooks socks in hell
