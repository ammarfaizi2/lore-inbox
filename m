Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264465AbTFKU3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTFKU2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:28:52 -0400
Received: from air-2.osdl.org ([65.172.181.6]:51855 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264472AbTFKU0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:26:17 -0400
Subject: Re: Build problems with Linux 2.5
From: Mark Haverkamp <markh@osdl.org>
To: Jay Denebeim <denebeim@deepthot.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306101427260.13724-100000@dent.deepthot.org>
References: <Pine.LNX.4.44.0306101427260.13724-100000@dent.deepthot.org>
Content-Type: text/plain
Message-Id: <1055363996.32400.0.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jun 2003 13:39:57 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 13:26, Jay Denebeim wrote:
> (.70, but I doubt that makes a difference)
> 
> Hi guys,
> 
>   I've been way out of kernel compiling for a long time, however I just
> took a job writing device drivers on Linux so I guess I'll be doing quite
> a bit of it again.  I've not built a kernel other than an occasional 'make
> rpm' on redhat since the 2.0 days, so be gentle with me.
> 
>   The problem I'm having is with the kernel.  My environment is a standard 
> Redhat 9 installation:
> 
> gcc-3.2.2-5
> binutils-2.13.90.0.18-9
> modutils-2.4.22-8
> kernel-smp-2.4.20-9
> 
>   The problem I'm having seems to be related to modutils.  When I make 
> very many modules I can't install the system because depmod can't find 
> symbols undery 2.4.  However using nm I can see that those symbols are 
> indeed defined.  If I make a bare bones system and only have the two or 
> three modules I need (I'm working with SCSI device drivers and need to 
> unload/reload the modules) the depmod passes, but the modprobe fails with 
> QM_MODULES: function unimplemented.
> 
>   So, I went grepping through the source code and QM_MODULES exists in 
> linux/module.h in 2.4, but not in 2.5.  Since modutils depends on that 
> functionality heavily modutils must have been re-written.  However the 
> latest version I can find on kernel.org is 2.4.25 and it still uses 
> QM_MODULES.  So, where is it?


http://www.kernel.org/pub/linux/kernel/people/rusty/modules/


> 
>   Are there other things I'm going to need for 2.5?  I've already figured 
> out LVM is totally different, and that breaks mkinitrd if I've got root on 
> a logical volume.  Anything else?
> 
>   Thanks in advance for your time.
> 
>   Jay
-- 
Mark Haverkamp <markh@osdl.org>

