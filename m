Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265923AbUA2EX4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 23:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUA2EX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 23:23:56 -0500
Received: from gate.crashing.org ([63.228.1.57]:28902 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265923AbUA2EXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 23:23:55 -0500
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugang <hugang@soulinfo.com>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040129100554.6453e6c8@localhost>
References: <20040119105237.62a43f65@localhost>
	 <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux>
	 <1074490463.10595.16.camel@gaston> <1074534964.2505.6.camel@laptop-linux>
	 <1074549790.10595.55.camel@gaston> <20040122211746.3ec1018c@localhost>
	 <1074841973.974.217.camel@gaston> <20040123183030.02fd16d6@localhost>
	 <1074912854.834.61.camel@gaston> <20040126181004.GB315@elf.ucw.cz>
	 <1075154452.6191.91.camel@gaston> <1075156310.2072.1.camel@laptop-linux>
	 <20040128202217.0a1f8222@localhost> <1075336478.30623.317.camel@gaston>
	 <20040129100554.6453e6c8@localhost>
Content-Type: text/plain
Message-Id: <1075350214.1231.18.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 29 Jan 2004 15:23:34 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-29 at 13:05, Hugang wrote:
> On Thu, 29 Jan 2004 11:34:53 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Ok, had a quick look. I  _HATE_ those horrible macros you did. Why
> > not just call asm functions or just inline the code ?
> 
> Good idea, But will try inline first. I can't sure change to call asm
> function can works. But I'll try.

As long as you make sure you save the LR in case you need it, you
can call asm functions. macros are _evil_ :)

Also, you can remove the code playing with BATs for now, they don't
really need to be saved. If the boot kernel sets them up any differently
than the saved kernel, we are in trouble anyway. And the G5 has no BATs.

Ben.


