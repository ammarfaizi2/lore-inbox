Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbULLPmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbULLPmX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 10:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbULLPmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 10:42:22 -0500
Received: from wylie.me.uk ([82.68.155.89]:54148 "EHLO mail.wylie.me.uk")
	by vger.kernel.org with ESMTP id S262084AbULLPkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 10:40:53 -0500
From: "Alan J. Wylie" <alan@wylie.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16828.26244.409792.573084@devnull.wylie.me.uk>
Date: Sun, 12 Dec 2004 15:40:52 +0000
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, EC <wingman@waika9.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: 2.4.29-pre1 OOPS early in boot with Intel ICH5 SATA controller
In-Reply-To: <41BB41DC.6020808@pobox.com>
References: <16824.8109.697757.673632@devnull.wylie.me.uk>
	<41BB41DC.6020808@pobox.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2004 13:52:12 -0500, Jeff Garzik <jgarzik@pobox.com> said:

> If you are getting an oops there, it looks like your ata_piix driver
> is mismatched from the libata core.  Did you compile them both at
> the same time, from the same source kernel?

Yes. Clean build, everything compiled into the kernel, no modules.

> The assembly code above is where function ata_host_add in
> libata-core.c calls "ap->ops->port_start", which definitely exists
> in ata_piix.c.

As I noted in my follow-up e-mail, and EC has confirmed, changing the
BIOS settings from Native Mode: Auto to Native Mode: Both works around
this problem.

-- 
Alan J. Wylie                                          http://www.wylie.me.uk/
"Perfection [in design] is achieved not when there is nothing left to add,
but rather when there is nothing left to take away."
  -- Antoine de Saint-Exupery
