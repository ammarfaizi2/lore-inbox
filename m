Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbTIGFgd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 01:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263070AbTIGFgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 01:36:33 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:1540 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263069AbTIGFgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 01:36:32 -0400
Date: Sun, 7 Sep 2003 07:36:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@suse.de>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6: spurious recompiles
Message-ID: <20030907053631.GB963@mars.ravnborg.org>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
References: <20030906201417.GI14436@fs.tum.de.suse.lists.linux.kernel> <33384.4.4.25.4.1062887601.squirrel@www.osdl.org.suse.lists.linux.kernel> <p733cf9lepj.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p733cf9lepj.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 12:44:24AM +0200, Andi Kleen wrote:
> "Randy.Dunlap" <rddunlap@osdl.org> writes:
> 
> x86-64 has the same problem. It always rebuilds arch/x86_64/ia32/vsyscall32.so,
> no matter if it has changed or not. I have not figured out why it does that.
> 
> vsyscall.S is an assembly file which depends on asm/offset.h, which 
> is regenerated each build. But the regeneration is written in a way to 
> not trigger rebuilds when nothing has changed. That works for everything
> else, just apparently not for the vsyscall.S file.

Hi Andi, I recall I have a mail from you about this.
Last time I looked I could not figure out what was wrong, but let
me try again.
Could you send me the output of "make V=1" for an otherwise clean compile.

	Sam
