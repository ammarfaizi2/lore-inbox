Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263629AbUDUTx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263629AbUDUTx4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 15:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbUDUTx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 15:53:56 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:4987 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S263629AbUDUTxz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 15:53:55 -0400
Date: Wed, 21 Apr 2004 22:04:41 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (7/9): oprofile for s390.
Message-ID: <20040421200441.GA2792@mars.ravnborg.org>
Mail-Followup-To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
	hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040421185051.GA7781@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040421185051.GA7781@mschwid3.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 08:50:51PM +0200, Martin Schwidefsky wrote:
> Hi Christoph,
> I changed the things you pointed out. Better now?

Could you also delete unrelated lines from arch/s390/oprofile/Makefile.

> +++ linux-2.6-s390/arch/s390/oprofile/Makefile	Wed Apr 21 20:25:32 2004
> +oprofile-y				:= $(DRIVER_OBJS) init.o
> +#oprofile-$(CONFIG_X86_LOCAL_APIC) 	+= nmi_int.o op_model_athlon.o \
> +					   op_model_ppro.o op_model_p4.o
> +#oprofile-$(CONFIG_X86_IO_APIC)		+= nmi_timer_int.o

The X86 stuff should go away.

	Sam
