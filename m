Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbUBTQzi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 11:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbUBTQzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 11:55:38 -0500
Received: from ns.suse.de ([195.135.220.2]:31375 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261339AbUBTQze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 11:55:34 -0500
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, jun.nakajima@intel.com,
       tom.l.nguyen@intel.com, tony.luck@intel.com
Subject: Re: [PATCH]2.6.3-rc2 MSI Support for IA64
References: <200402201747.i1KHlnqU005488@snoqualmie.dp.intel.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: YOW!!  Now I understand advanced MICROBIOLOGY
 and th' new TAX REFORM laws!!
Date: Fri, 20 Feb 2004 17:54:44 +0100
In-Reply-To: <200402201747.i1KHlnqU005488@snoqualmie.dp.intel.com> (long's
 message of "Fri, 20 Feb 2004 09:47:49 -0800")
Message-ID: <jeeksp4ror.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

long <tlnguyen@snoqualmie.dp.intel.com> writes:

> @@ -316,6 +310,19 @@
>  	return current_vector;
>  }
>  
> +int ia64_alloc_vector(void)
> +{
> +	static int next_vector = IA64_FIRST_DEVICE_VECTOR;
> +
> +	if (next_vector > IA64_LAST_DEVICE_VECTOR)
> +		/* XXX could look for sharable vectors instead of panic'ing... */
> +		panic("ia64_alloc_vector: out of interrupt vectors!");
> +
> +	nr_alloc_vectors++;
> +
> +	return next_vector++;
> +}
> +

IMHO this should be CONFIG_IA64 only.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
