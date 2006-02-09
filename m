Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932574AbWBIQNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbWBIQNf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 11:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWBIQNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 11:13:35 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:3979 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932574AbWBIQNf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 11:13:35 -0500
Date: Thu, 9 Feb 2006 17:13:31 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Eric Dumazet <dada1@cosmosbay.com>,
       riel@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       mingo@elte.hu, ak@muc.de, 76306.1226@compuserve.com, wli@holomorphy.com,
       Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-ID: <20060209161331.GE20554@osiris.boeblingen.de.ibm.com>
References: <200602051959.k15JxoHK001630@hera.kernel.org> <Pine.LNX.4.63.0602081728590.31711@cuia.boston.redhat.com> <20060208190512.5ebcdfbe.akpm@osdl.org> <20060208190839.63c57a96.akpm@osdl.org> <43EAC6BE.2060807@cosmosbay.com> <20060208204502.12513ae5.akpm@osdl.org> <20060209160808.GL18730@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060209160808.GL18730@localhost.localdomain>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Presumably not all architectures are doing that.
> powerpc/ppc64, for instance, determines the number of possible cpus
> from information exported by firmware (and I'm mystified as to why
> other platforms don't do this).  So it's typical to have a kernel an a
> pSeries partition with NR_CPUS=128, but cpu_possible_map = 0xff.

Simply because there is no such interface on s390. The only thing we know
for sure is that if we are running under z/VM the user is free to
configure up to 63 additional virtual cpus on the fly...

Heiko
