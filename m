Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261328AbTCYBhP>; Mon, 24 Mar 2003 20:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbTCYBgv>; Mon, 24 Mar 2003 20:36:51 -0500
Received: from ns.suse.de ([213.95.15.193]:25102 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261328AbTCYBfO>;
	Mon, 24 Mar 2003 20:35:14 -0500
Date: Tue, 25 Mar 2003 02:46:20 +0100
From: Andi Kleen <ak@suse.de>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: Andi Kleen <ak@suse.de>, davej@codemonkey.org.uk, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][x86-64] make the pci aperture cachable
Message-ID: <20030325014620.GB3548@wotan.suse.de>
References: <200303241641.h2OGfw35008208@deviant.impure.org.uk> <1048527139.12339.109.camel@averell> <200303250125.39564.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303250125.39564.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As this patch has been applied anyway here is a patch to make the pci aperture 
> cachable for 2.5.66.

It actually needs a different change. This is just the fallback path
when your BIOS didn't set up an aperture (no AGP port). In case of an
existing aperture it needs to remap the IOMMU half.

I fixed it now in my tree.

-Andi
