Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319695AbSIMPy5>; Fri, 13 Sep 2002 11:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319696AbSIMPy5>; Fri, 13 Sep 2002 11:54:57 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:61422 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S319695AbSIMPy4>; Fri, 13 Sep 2002 11:54:56 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020913173540.74c49e74.hugang@soulinfo.com> 
References: <20020913173540.74c49e74.hugang@soulinfo.com> 
To: Hu Gang <hugang@soulinfo.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch]Make 2.5.3x serial can compile. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 13 Sep 2002 16:58:53 +0100
Message-ID: <1707.1031932733@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hugang@soulinfo.com said:
> +#define ALPHA_KLUDGE_MCR  (UART_MCR_OUT2 | UART_MCR_OUT1) 

Operative word being 'kludge'. Fix it properly, let the board-specific code 
specify default values for and masks on whether the user can change each 
I/O bit when it calls register_serial() to register the chip.

--
dwmw2


