Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTEUJ2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 05:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTEUJ2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 05:28:12 -0400
Received: from ns.suse.de ([213.95.15.193]:36106 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261823AbTEUJ2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 05:28:12 -0400
To: mikpe@csd.uu.se
Cc: tripperda@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: pat support in the kernel
References: <20030520185409.GB941@hygelac.suse.lists.linux.kernel>
	<16074.33371.411219.528228@gargle.gargle.HOWL.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 21 May 2003 11:41:11 +0200
In-Reply-To: <16074.33371.411219.528228@gargle.gargle.HOWL.suse.lists.linux.kernel>
Message-ID: <p73brxwzlfr.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mikpe@csd.uu.se writes:

> (Large pages ignoring PAT index bit 2, or something like that.)

change_page_attr will force 4K pages for these anyways, so for the kernel
direct mapping it should not be an issue. 

For the hugetlbfs user mapping you may need to check the case, but
it's probably reasonable to EINVAL there.

Other than that everything should be 4K mapped.

-Andi
