Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270237AbTHLMJa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 08:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270230AbTHLMIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 08:08:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54533 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270237AbTHLMH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 08:07:59 -0400
Date: Tue, 12 Aug 2003 13:07:55 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Rob Landley <rob@landley.net>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, kernelbugzilla@kuntnet.org
Subject: Re: [Bug 1068] New: Errors when loading airo module
Message-ID: <20030812130755.B4345@flint.arm.linux.org.uk>
Mail-Followup-To: Rob Landley <rob@landley.net>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kernelbugzilla@kuntnet.org
References: <51060000.1060524422@[10.10.2.4]> <200308120447.00105.rob@landley.net> <20030812123214.B10895@flint.arm.linux.org.uk> <200308120738.00641.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200308120738.00641.rob@landley.net>; from rob@landley.net on Tue, Aug 12, 2003 at 07:38:00AM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 07:38:00AM -0400, Rob Landley wrote:
> Okay, so which non-Cardbus PCMCIA slections, which are not legal to enable 
> without CONFIG_ISA, are missing a kconfig dependency on CONFIG_ISA?  (I 
> guessed it was the ARM specific ones, but it was just a guess...)

If you have PCMCIA enabled, but CONFIG_ISA disabled and it discovers
that you have ISA interrupts, then Bad Things Will Happen.  Howver,
if you have PCMCIA enabled and it doesn't find any ISA interrupts,
we couldn't care less about the setting of CONFIG_ISA.

We should probably force the per-socket irq_mask to zero if CONFIG_ISA
isn't set... I'll look into that once the hot weather has abaited.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

