Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVFTWUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVFTWUr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 18:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbVFTWUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:20:00 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:18671 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262124AbVFTV7J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:59:09 -0400
Subject: Re: [PATCH 2/2] I-pipe: x86 port
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Philippe Gerum <rpm@xenomai.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42B35B0F.1000302@xenomai.org>
References: <42B35B0F.1000302@xenomai.org>
Content-Type: text/plain
Organization: MontaVista
Date: Mon, 20 Jun 2005 14:58:46 -0700
Message-Id: <1119304726.32310.19.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-18 at 01:21 +0200, Philippe Gerum wrote:

> +#define local_save_flags(x)	((x) = __ipipe_test_root())
> +#define local_irq_save(x)	((x) = __ipipe_test_and_stall_root())
> +#define local_irq_restore(x)	__ipipe_restore_root(x)
> +#define local_irq_disable()	__ipipe_stall_root()
> +#define local_irq_enable()	__ipipe_unstall_root()
> +
> +#define irqs_disabled()		__ipipe_test_root()


If you want to integrate with newer RT patches , (I'm not sure which one
this is on) .. You could modify the above so that it uses the soft irq's
off flags  . So if linux is in a soft irq disable than it's equal to a
stall on the ipipe ..

Daniel

