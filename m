Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWCAMyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWCAMyH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 07:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWCAMyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 07:54:07 -0500
Received: from colin.muc.de ([193.149.48.1]:56590 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750888AbWCAMyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 07:54:06 -0500
Date: 1 Mar 2006 13:54:05 +0100
Date: Wed, 1 Mar 2006 13:54:05 +0100
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [patch 2/5] Remove unnecessary lapic definition from acpidef.h
Message-ID: <20060301125405.GB72515@muc.de>
References: <20060301001557.318047000@araj-sfield> <20060301001722.746570000@araj-sfield>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301001722.746570000@araj-sfield>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 04:15:59PM -0800, Ashok Raj wrote:
> Dont know why this exists... just happened to trip me when i used a 
> variable name with lapic, and until i looked at the pre-processed
> output couldnt figure out we had a lame definition like this.
> 
> Hope iam not breaking anything here..

No, the file is a mess anyways.

> 
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> ------------------------------------------------
>  include/asm-i386/apicdef.h   |    1 -
>  include/asm-x86_64/apicdef.h |    2 --
>  2 files changed, 3 deletions(-)
> 
> Index: linux-2.6.16-rc1-mm4/include/asm-i386/apicdef.h
> ===================================================================
> --- linux-2.6.16-rc1-mm4.orig/include/asm-i386/apicdef.h
> +++ linux-2.6.16-rc1-mm4/include/asm-i386/apicdef.h
> @@ -120,7 +120,6 @@
>   */
>  #define u32 unsigned int

Like this should go too.

>  
> -#define lapic ((volatile struct local_apic *)APIC_BASE)

I'll take a stab at cleaning it up.

Thanks,
-Andi
