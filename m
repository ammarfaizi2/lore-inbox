Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265587AbTAOBBl>; Tue, 14 Jan 2003 20:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265603AbTAOBBk>; Tue, 14 Jan 2003 20:01:40 -0500
Received: from are.twiddle.net ([64.81.246.98]:44936 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S265587AbTAOBBk>;
	Tue, 14 Jan 2003 20:01:40 -0500
Date: Tue, 14 Jan 2003 17:10:31 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [MODULES] fix weak symbol handling
Message-ID: <20030114171031.B5751@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20030113110036.A873@twiddle.net> <20030114032138.5C1E92C2C5@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030114032138.5C1E92C2C5@lists.samba.org>; from rusty@rustcorp.com.au on Tue, Jan 14, 2003 at 02:11:30PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 02:11:30PM +1100, Rusty Russell wrote:
> PPC64 (not in tree yet):
> 
> +		/* REL24 references to (external) .function won't
> +                   resolve; deal with that below */
> +		if (!sym->st_value
> +		    && ELF64_R_TYPE(rela[i].r_info) != R_PPC_REL24) {
> +			printk("%s: Unknown symbol %s (index %u)\n",
> +			       me->name, strtab + sym->st_name,
> +			       sym->st_shndx);
> +			return -ENOENT;
> +		}
> 
> That's *why* find_symbol_internal() is not static, and why we don't
> fail in simplify_symbol() 8(
> 
> Hope that clarifies,

Not really.  Send me the whole file?


r~
