Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbTJOHyd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 03:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbTJOHyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 03:54:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34576 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262419AbTJOHyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 03:54:32 -0400
Date: Wed, 15 Oct 2003 08:54:28 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Patrick Mochel <mochel@osdl.org>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bug in init_i82365 wrt sysfs
Message-ID: <20031015085428.A25241@flint.arm.linux.org.uk>
Mail-Followup-To: Patrick Mochel <mochel@osdl.org>,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031010090104.A23806@flint.arm.linux.org.uk> <Pine.LNX.4.44.0310141605160.803-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0310141605160.803-100000@cherise>; from mochel@osdl.org on Tue, Oct 14, 2003 at 04:13:10PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 04:13:10PM -0700, Patrick Mochel wrote:
> So, that means you simply cannot register devices that are on the same bus
> from inside a ->probe() function, or unregister them in ->remove(). At
> least not the way it is. Any suggestions?

No.  It means that PCMCIA/Cardbus will remain to be fairly fragile
with an over-complex initialisation to work around this problem.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
