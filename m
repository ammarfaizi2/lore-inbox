Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbQKONtj>; Wed, 15 Nov 2000 08:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129097AbQKONt2>; Wed, 15 Nov 2000 08:49:28 -0500
Received: from Cantor.suse.de ([194.112.123.193]:30213 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129061AbQKONtU>;
	Wed, 15 Nov 2000 08:49:20 -0500
Date: Wed, 15 Nov 2000 14:19:16 +0100
From: Andi Kleen <ak@suse.de>
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory management bug
Message-ID: <20001115141916.A12673@gruyere.muc.suse.de>
In-Reply-To: <C1256998.004585F4.00@d12mta07.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <C1256998.004585F4.00@d12mta07.de.ibm.com>; from schwidefsky@de.ibm.com on Wed, Nov 15, 2000 at 01:39:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2000 at 01:39:13PM +0100, schwidefsky@de.ibm.com wrote:
> +extern pte_t empty_bad_pte_table[];
>  extern __inline__ void free_pte_fast(pte_t *pte)
>  {
> +       if (pte == empty_bad_pte_table)
> +               return;

I guess that should be BUG() instead of return, so that the callers can be 
fixed.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
