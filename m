Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264324AbTDWXxi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 19:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbTDWXxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 19:53:38 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:19175 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264324AbTDWXxg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 19:53:36 -0400
Date: Wed, 23 Apr 2003 16:55:10 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Pavel Machek <pavel@ucw.cz>
cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Marc Giger <gigerstyle@gmx.ch>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <1591030000.1051142110@flay>
In-Reply-To: <20030423235820.GB32577@atrey.karlin.mff.cuni.cz>
References: <1051136725.4439.5.camel@laptop-linux> <1584040000.1051140524@flay> <20030423235820.GB32577@atrey.karlin.mff.cuni.cz>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, but if all the swaps gets used, you go OOM and randomly kill
> processes. That means that machines have way more swap than they need.
> 
> If you really want to "solve" it reliably, you can always
> 
> swapon /dev/hdfoo666
> 
> where hdfoo666 is as big as ram, just before starting swsusp. We could
> even make swapon part of swsusp where its locked to kill races.
> 
> But I believe its not needed. Problem just is not there in practise.

OK, well suppose RAM is full, and swap is almost full (less than used
RAM left). System is still running fine, no OOM. But suspend can't work, 
AFAICS. 

Saving a separate area to save RAM into seems like the only deterministic 
method to me.

M.

