Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129449AbQKCMyU>; Fri, 3 Nov 2000 07:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129026AbQKCMyK>; Fri, 3 Nov 2000 07:54:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42610 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129449AbQKCMyH>; Fri, 3 Nov 2000 07:54:07 -0500
Subject: Re: [PATCH] x86 boot time check for cpu features
To: bgerst@didntduck.org (Brian Gerst)
Date: Fri, 3 Nov 2000 12:54:10 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux kernel mailing list)
In-Reply-To: <3A02212F.8B1BA2DC@didntduck.org> from "Brian Gerst" at Nov 02, 2000 09:21:35 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13rgMG-0003Uc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	lea	cpuid_fail_msg, %si
> +	call	prtstr
> +1:	jmp	1b
> +cpuid_fail_msg:
> +	.string	"Required CPU features are not present - compile kernel for the proper CPU type."
> +cpuid_pass:

Only one very minor suggestion

1:	hlt
	j 1b


Q:	are any of the things you test present in processors only after we
	do magic 'cpuid' enable invocations ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
