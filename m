Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbTJPLbM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 07:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbTJPLbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 07:31:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45960 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262860AbTJPLbK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 07:31:10 -0400
Message-ID: <3F8E8170.8000101@pobox.com>
Date: Thu, 16 Oct 2003 07:30:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
CC: linux-kernel@vger.kernel.org, Brard Roudier <groudier@free.fr>
Subject: Re: [patch][2/3] qlogic: call request_irq() with private data
References: <20031016015349.GB1765@cathedrallabs.org>
In-Reply-To: <20031016015349.GB1765@cathedrallabs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aristeu Sergio Rozanski Filho wrote:
> +#ifdef QL_USE_IRQ
> +	if (qlirq < 0 || request_irq(qlirq, do_ql_ihandl, 0, "qlogicfas", hreg))
> +		goto free_scsi_host;
> +#endif
>  
>  	return hreg;
>  
> +free_scsi_host:
> +	kfree(hreg);


should be scsi_host_put() on that last line...

