Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUHSJzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUHSJzb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 05:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUHSJzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 05:55:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30227 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264665AbUHSJzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 05:55:14 -0400
Date: Thu, 19 Aug 2004 10:55:08 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Karel Gardas <kgardas@objectsecurity.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBM T22/APM suspend does not work with yenta_socket module loaded on 2.6.8.1
Message-ID: <20040819105508.E546@flint.arm.linux.org.uk>
Mail-Followup-To: Karel Gardas <kgardas@objectsecurity.com>,
	linux-kernel@vger.kernel.org
References: <20040819103006.D546@flint.arm.linux.org.uk> <Pine.LNX.4.43.0408191145510.1006-100000@thinkpad.gardas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.43.0408191145510.1006-100000@thinkpad.gardas.net>; from kgardas@objectsecurity.com on Thu, Aug 19, 2004 at 11:46:53AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 11:46:53AM +0200, Karel Gardas wrote:
> I hope I have not make any mistake, but diff seems to be pretty bigger:

Ok, could you try commenting out the call to pci_set_power_state() in
yenta_dev_suspend() please?  I wonder if your BIOS doesn't like us
placing the cardbus bridge into D3.

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
