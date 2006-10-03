Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030458AbWJCSpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030458AbWJCSpf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 14:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbWJCSpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 14:45:35 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:58272 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030458AbWJCSpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 14:45:33 -0400
Subject: Re: [PATCH 6/12] i386: CONFIG_PHYSICAL_START cleanup
From: Dave Hansen <haveblue@us.ibm.com>
To: vgoyal@in.ibm.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, horms@verge.net.au, lace@jankratochvil.net,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, maneesh@in.ibm.com
In-Reply-To: <20061003171531.GF3164@in.ibm.com>
References: <20061003170032.GA30036@in.ibm.com>
	 <20061003171531.GF3164@in.ibm.com>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 11:45:09 -0700
Message-Id: <1159901109.18746.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 13:15 -0400, Vivek Goyal wrote:
> diff -puN arch/i386/boot/compressed/misc.c~i386-CONFIG_PHYSICAL_START-cleanup arch/i386/boot/compressed/misc.c
> --- linux-2.6.18-git17/arch/i386/boot/compressed/misc.c~i386-CONFIG_PHYSICAL_START-cleanup      2006-10-02 13:17:58.000000000 -0400
> +++ linux-2.6.18-git17-root/arch/i386/boot/compressed/misc.c    2006-10-02 14:33:44.000000000 -0400
> @@ -9,11 +9,11 @@
>   * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
>   */
>  
> +#include <linux/config.h>
>  #include <linux/linkage.h>
>  #include <linux/vmalloc.h>
>  #include <linux/screen_info.h> 

Isn't config.h implicitly included everywhere by the build system now?
I don't think this is needed.

-- Dave

