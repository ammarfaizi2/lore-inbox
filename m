Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWBGSos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWBGSos (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 13:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWBGSos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 13:44:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35517 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964875AbWBGSor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 13:44:47 -0500
Date: Tue, 7 Feb 2006 10:43:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, dada1@cosmosbay.com,
       heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
       davem@davemloft.net, James.Bottomley@steeleye.com, mingo@elte.hu,
       axboe@suse.de, anton@samba.org, wli@holomorphy.com, ak@muc.de
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
In-Reply-To: <20060207183018.GA29056@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0602071036050.3854@g5.osdl.org>
References: <200602051959.k15JxoHK001630@hera.kernel.org>
 <20060207151541.GA32139@osiris.boeblingen.de.ibm.com> <43E8CA10.5070501@cosmosbay.com>
 <Pine.LNX.4.64.0602070833590.3854@g5.osdl.org> <20060207093458.176ac271.akpm@osdl.org>
 <Pine.LNX.4.64.0602070946190.3854@g5.osdl.org> <20060207183018.GA29056@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Feb 2006, Dipankar Sarma wrote:
> 
> One would think so, but I recall not all archs did that. Alpha for
> example sets up cpu_possible_map in smp_prepare_cpus(). It however
> makes more sense to fix the arch then use NR_CPUS, IMO.

Ehh? alpha does it in setup_smp(), which in turn is called very early from 
setup_arch().

Were you perhaps thinking of something else? Or am I just going blind and 
confused?

		Linus
