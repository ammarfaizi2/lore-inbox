Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbUAXXsi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 18:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbUAXXsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 18:48:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:4062 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263424AbUAXXsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 18:48:36 -0500
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
Cc: Hugang <hugang@soulinfo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040124172800.43495cf3@jack.colino.net>
References: <20040119105237.62a43f65@localhost>
	 <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux>
	 <1074490463.10595.16.camel@gaston> <1074534964.2505.6.camel@laptop-linux>
	 <1074549790.10595.55.camel@gaston> <20040122211746.3ec1018c@localhost>
	 <1074841973.974.217.camel@gaston> <20040123183030.02fd16d6@localhost>
	 <1074912854.834.61.camel@gaston>  <20040124172800.43495cf3@jack.colino.net>
Content-Type: text/plain
Message-Id: <1074988008.1262.125.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 25 Jan 2004 10:46:49 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-01-25 at 03:28, Colin Leroy wrote:
> On 24 Jan 2004 at 13h01, Benjamin Herrenschmidt wrote:
> 
> Hi, 
> 
> > The patch is against my tree currently, and the arch/ppc/kernel/pmdisk.S file
> > is appended as-is (not in patch form). 
> 
> Didn't you forget to include include/asm-ppc/suspend.h ? ;-)

Yes, but you could have re-created it easily: 


static inline int arch_prepare_suspend(void)
{
	return 0;
}

static inline void save_processor_state(void)
{
}

static inline void restore_processor_state(void)
{
}



