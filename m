Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264324AbTLPD5r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 22:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264325AbTLPD5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 22:57:47 -0500
Received: from qlink.QueensU.CA ([130.15.126.18]:43239 "EHLO qlink.queensu.ca")
	by vger.kernel.org with ESMTP id S264324AbTLPD5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 22:57:46 -0500
Subject: Re: HT schedulers' performance on single HT processor
From: Nathan Fredrickson <8nrf@qlink.queensu.ca>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1071536102.3fde57e670996@vds.kolivas.org>
References: <200312130157.36843.kernel@kolivas.org>
	 <1071431363.19011.64.camel@rocky>  <200312152111.52949.kernel@kolivas.org>
	 <1071533802.24673.35.camel@rocky>
	 <1071536102.3fde57e670996@vds.kolivas.org>
Content-Type: text/plain
Message-Id: <1071547055.24916.14.camel@rocky>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 15 Dec 2003 22:57:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-15 at 19:55, Con Kolivas wrote:
> Well since you asked... I've been looking for someone with more HT cpus to give
> a much simpler approach a try. Here's a sample patch for vanilla test11 with
> HT. This one actually helps UP HT performance ever so slightly and I'd be
> curious to see if it does anything on more cpus.

Not much change with this patch.  The new result is most similar to
vanilla test11 with HT.  Both perform worse than no-HT under partial
load.  Here are the results from earlier with the new test case
appended:

          X =  1     2     3     4     5     6     7     8     9    16
1phys UP      1.00  1.00  1.00  1.00  1.00  1.00  1.00  1.00  1.00  1.00
4phys SMP     1.00  0.99  0.51  0.35  0.27  0.27  0.27  0.27  0.27  0.27
4phys HT      1.01  1.00  0.55  0.40  0.33  0.29  0.27  0.26  0.25  0.26
4phys HT(w26) 1.01  1.01  0.54  0.37  0.31  0.27  0.26  0.26  0.26  0.26
4phys HT(C1)  1.01  1.00  0.52  0.36  0.29  0.28  0.27  0.26  0.25  0.26
4phys HT(ht3) 1.01  1.00  0.53  0.39  0.33  0.29  0.27  0.26  0.26  0.26

Nathan

