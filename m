Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268526AbUHYGKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268526AbUHYGKn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 02:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268397AbUHYGKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 02:10:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:5845 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268526AbUHYGJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 02:09:50 -0400
Date: Tue, 24 Aug 2004 22:52:08 -0700
From: Greg KH <greg@kroah.com>
To: Norbert Preining <preining@logic.at>
Cc: "Nemosoft Unv." <nemosoft@smcc.demon.nl>,
       Linux USB Mailing List 
	<linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: kernel 2.6.8 pwc patches and counterpatches
Message-ID: <20040825055208.GB16147@kroah.com>
References: <1092793392.17286.75.camel@localhost> <1092845135.8044.22.camel@localhost> <20040823221028.GB4694@kroah.com> <200408250058.24845@smcc.demon.nl> <20040824230458.GA12422@kroah.com> <20040825053516.GA19771@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040825053516.GA19771@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 07:35:16AM +0200, Norbert Preining wrote:
> 
> Bummer. This is rubbish. And I am sure that this is not the intention of
> Linus comments. IF the module would be NON functional without the closed
> plugin, then yes, rip it out. But it is useable, and this hook *can* be
> used for closed modules, but also for other modules. 

But it isn't, that's the point.

> It really looks like personal stuff going on here, not really objective
> discussion on this point.

Nothing personal here.  The GPL code has a exported symbol explicitly to
be able to load a closed source decoder module.  Because of that, I've
deleted that symbol (and the surrounding logic, as it's no longer
needed.)  One could also argue that no in-kernel code needs that symbol
exported, so it should be removed for that reason alone.

That's all I've done.  The in-kernel module still works the same as it
always did if you never used the closed source decoder.

thanks,

greg k-h
