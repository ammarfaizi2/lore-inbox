Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267924AbUHPUCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267924AbUHPUCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 16:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267927AbUHPUCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 16:02:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2441 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267924AbUHPUCD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 16:02:03 -0400
Date: Mon, 16 Aug 2004 21:01:59 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: kbuild + kconfig: Updates
Message-ID: <20040816200159.GK12308@parcelfarce.linux.theplanet.co.uk>
References: <20040815201224.GI7682@mars.ravnborg.org> <20040815204229.GJ12308@parcelfarce.linux.theplanet.co.uk> <20040816204550.GA20956@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040816204550.GA20956@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 10:45:50PM +0200, Sam Ravnborg wrote:
>  $(single-used-m): %.o: %.c FORCE
> +	$(cmd_force_checksrc)
>  	$(call if_changed_rule,cc_o_c)
>  	@{ echo $(@:.o=.ko); echo $@; } > $(MODVERDIR)/$(@F:.o=.mod)
>  
> 
> That should do it?
> I will push this if you are OK with it.

Uhh...  It ends up running sparse *twice* and still runs gcc on every
file.
