Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266759AbUFYPUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266759AbUFYPUU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 11:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266762AbUFYPUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 11:20:20 -0400
Received: from nevyn.them.org ([66.93.172.17]:43175 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S266759AbUFYPTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 11:19:11 -0400
Date: Fri, 25 Jun 2004 11:18:58 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: swsusp.S: meaningfull assembly labels
Message-ID: <20040625151858.GA27013@nevyn.them.org>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@zip.com.au>,
	kernel list <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@digitalimplant.org>
References: <20040625115936.GA2849@elf.ucw.cz> <Pine.LNX.4.53.0406250827250.28070@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0406250827250.28070@chaos>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 08:37:45AM -0400, Richard B. Johnson wrote:
> NO! You just made those labels public! The LOCAL symbols need to
> begin with ".L".  Now, if you have a 'copy_loop' in another module,
> linked with this, anywhere in the kernel, they will share the
> same address -- not what you expected, I'm sure! The assembler
> has some strange rules you need to understand. Use `nm` and you
> will find that your new labels are in the object file!

Er, no.  They'll show up in the object file.  That doesn't mean they're
global; static symbols also show up in the object file.

-- 
Daniel Jacobowitz
