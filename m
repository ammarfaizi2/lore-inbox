Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265778AbTGIJNW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 05:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265862AbTGIJNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 05:13:22 -0400
Received: from holomorphy.com ([66.224.33.161]:53673 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265778AbTGIJNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 05:13:21 -0400
Date: Wed, 9 Jul 2003 02:29:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.74-mm3
Message-ID: <20030709092907.GO15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030708223548.791247f5.akpm@osdl.org> <20030709092433.GA27280@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030709092433.GA27280@waste.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 04:24:33AM -0500, Matt Mackall wrote:
> -#define apm_save_cpus()	0
> +#define apm_save_cpus()	(current->cpus_allowed)
>  #define apm_restore_cpus(x)	(void)(x)

It's trying to describe an empty set of cpus. This is denoted by
CPU_MASK_NONE in the cpumask_t bits.


-- wli
