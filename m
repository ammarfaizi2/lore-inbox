Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWBEO1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWBEO1g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 09:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWBEO1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 09:27:35 -0500
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:44427 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1750838AbWBEO1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 09:27:35 -0500
Subject: Re: [PATCH, RFC] Driver for reading HP laptop LCD brightness
From: Arjan van de Ven <arjan@infradead.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060205135517.GA21795@srcf.ucam.org>
References: <20060205135517.GA21795@srcf.ucam.org>
Content-Type: text/plain
Date: Sun, 05 Feb 2006 15:27:26 +0100
Message-Id: <1139149647.3131.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-05 at 13:55 +0000, Matthew Garrett wrote:
> +	if (enable==0) {
> +		return snprintf(buf, PAGE_SIZE, "NA\n");
> +	}
> +
> +	disable_irq(8);
> +
> +	outb(0x97, 0x72);
> +	value = inb(0x73);
> +	
> +	enable_irq(8);
> +

disable_irq() and enable_irq() are really really evil. Are you sure you
need these? To me on first sight it looks like a bug (think of shared
interrupts for example), can you explain what you are trying to achieve
with these?

Greetings,
     Arjan van de Ven

