Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279985AbRKDNik>; Sun, 4 Nov 2001 08:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279987AbRKDNia>; Sun, 4 Nov 2001 08:38:30 -0500
Received: from mx03.uni-tuebingen.de ([134.2.3.13]:6155 "EHLO
	mx03.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S279985AbRKDNiS>; Sun, 4 Nov 2001 08:38:18 -0500
Date: Sun, 4 Nov 2001 14:36:31 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Message-ID: <20011104143631.B1162@pelks01.extern.uni-tuebingen.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E15zF9H-0000NL-00@wagner> <20011104013951Z16981-4784+741@humbolt.nl.linux.org> <20011104030832.C26842@unthought.net> <160MMf-1ptGtMC@fmrl05.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.12i
In-Reply-To: <160MMf-1ptGtMC@fmrl05.sul.t-online.com>; from tim@tjansen.de on Sun, Nov 04, 2001 at 01:30:06PM +0100
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 01:30:06PM +0100, Tim Jansen wrote:
> The problem is that it is almost impossible to offer human-readable 
> interfaces that will be backward-compatible. As soon as you have a 
> well-formatted output, like /proc/partitions, you can not add a new field 
> without breaking user-space applications. 
> What you could do is to establish rules for files like /proc/partitions ("if 
> there are more than 4 space-separated alphanumeric strings per line in 
> /proc/partitions then ignore the additional fields"), but you won't find such 
> a rule that is useful for every file and still offers a nice human-readable 
> format.

Certainly you can further fields without breaking (well-written) apps. That's
what the first line in /proc/partitions is for. When adding a new column,
you also give it a new tag in the header. Ask RedHat how many apps broke
when they started patching sard into their kernels.

Adding new fields is even easier with /proc/stat-style key:value pairs. Both
styles are human- as well as machine readable. Problems only arise when
someone changes the semantics of a certain field without changing the tag.
But luckily these kinds of changes never happen in a stable kernel series...

Regards,

Daniel.

