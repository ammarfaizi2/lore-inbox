Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbTHaUZQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 16:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbTHaUZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 16:25:15 -0400
Received: from ns.suse.de ([195.135.220.2]:42447 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262665AbTHaUZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 16:25:12 -0400
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OProfile: correct CPU type for x86-64
References: <20030831191937.GA32426@compsoc.man.ac.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 31 Aug 2003 22:25:08 +0200
In-Reply-To: <20030831191937.GA32426@compsoc.man.ac.uk.suse.lists.linux.kernel>
Message-ID: <p73ad9po9qz.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon <levon@movementarian.org> writes:

> +				break;
> +#if defined(CONFIG_X86_64)
> +			case 0xf:
> +				model = &op_athlon_spec;
> +				nmi_ops.cpu_type = "x86-64/hammer";
> +				break;
> +#endif /* CONFIG_X86_64 */

The ifdef is not needed. The case is valid for i386 too, when running
an Opteron with an 32bit kernel. In that case you also want the user tools
to select the Opteron events.

-Andi

