Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbTEMX6l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 19:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTEMX6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 19:58:41 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:60677 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id S263614AbTEMX6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 19:58:39 -0400
Message-ID: <3EC18973.9000200@snapgear.com>
Date: Wed, 14 May 2003 10:10:27 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chris@wirex.com>
CC: linux-kernel@vger.kernel.org, hch@infradead.org, gregkh@kroah.com,
       linux-security-module@wirex.com
Subject: Re: [PATCH] Early init for security modules
References: <20030512200309.C20068@figure1.int.wirex.com> <20030512201052.P19432@figure1.int.wirex.com>
In-Reply-To: <20030512201052.P19432@figure1.int.wirex.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Chris Wright wrote:
> This is just the arch specific linker bits for the early initialization
> for security modules patch.  Does this look sane for this arch?

Yep, looks good to me.

Regards
Greg



> --- 1.7/arch/m68knommu/vmlinux.lds.S	Wed Apr  2 00:42:56 2003
> +++ edited/arch/m68knommu/vmlinux.lds.S	Mon May 12 16:16:58 2003
> @@ -305,6 +305,9 @@
>  		__con_initcall_start = .;
>  		*(.con_initcall.init)
>  		__con_initcall_end = .;
> +		__security_initcall_start = .;
> +		*(.security_initcall.init)
> +		__security_initcall_end = .;
>  		. = ALIGN(4);
>  		__initramfs_start = .;
>  		*(.init.ramfs)
> 

-- 
------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude          EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

