Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWEBKVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWEBKVP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 06:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWEBKVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 06:21:15 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:2463 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751256AbWEBKVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 06:21:15 -0400
Subject: Re: [patch 00/14] remap_file_pages protection support
From: Arjan van de Ven <arjan@linux.intel.com>
To: blaisorblade@yahoo.it
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060430172953.409399000@zion.home.lan>
References: <20060430172953.409399000@zion.home.lan>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 02 May 2006 12:21:06 +0200
Message-Id: <1146565266.32045.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This will be useful since the VMA lookup at fault time can be a bottleneck for
> some programs (I've received a report about this from Ulrich Drepper and I've
> been told that also Val Henson from Intel is interested about this). 

I've not seen much of this if any at all, the various caches that are in
place for these lookups seem to function quite well; what we did see was
glibc's malloc implementation being mistuned resulting in far too many
mmaps than needed (which in turn leads to far too much page zeroing
which is the really expensive part. It's not the vma lookup that is
expensive, it's the page zeroing)

