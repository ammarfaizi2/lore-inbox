Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbULFTEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbULFTEC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 14:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbULFTEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 14:04:02 -0500
Received: from pg-fw.paradigmgeo.com ([192.117.235.33]:33349 "EHLO
	exil1.paradigmgeo.net") by vger.kernel.org with ESMTP
	id S261607AbULFTD5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 14:03:57 -0500
Content-class: urn:content-classes:message
Subject: RE: Correctly determine amount of "free memory"
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Mon, 6 Dec 2004 21:00:57 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <06EF4EE36118C94BB3331391E2CDAAD9CD06D4@exil1.paradigmgeo.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Correctly determine amount of "free memory"
Thread-Index: AcTbwYo5j+S6lmIiSNepe8j1ElzJ2gAALSyA
From: "Gregory Giguashvili" <Gregoryg@ParadigmGeo.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's not really a meaningful question. 
Sorry, I did my best :)

> The qualified answer is that /proc/meminfo gives you the available
information and what number 
> you want depends upon what you plan to do with it. Swapping is not
necessarily the right metric 
> for two reasons.
I plan to commit the largest chunk of memory in the quickest way. This
operation may be slowed down by swapping - that's why I don't want to
get there. If swapping is not the right metric, what is then? 

According to my humble experiments with 2.4 and 2.6 kernels, some cashed
memory reported in /proc/meminfo is reused and some is swapped. The real
problem here is that I couldn't find the right way to "predict" how much
cached memory will be discarded before starting to swap when system is
low on available RAM.

Thanks
Giga
