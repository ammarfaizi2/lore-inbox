Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265669AbSJXXS0>; Thu, 24 Oct 2002 19:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265708AbSJXXS0>; Thu, 24 Oct 2002 19:18:26 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:6930 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265669AbSJXXSZ>;
	Thu, 24 Oct 2002 19:18:25 -0400
Date: Thu, 24 Oct 2002 16:22:58 -0700
From: Greg KH <greg@kroah.com>
To: Scott Murray <scottm@somanetworks.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Steven Dake <sdake@mvista.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] Advanced TCA SCSI Disk Hotswap
Message-ID: <20021024232258.GA26093@kroah.com>
References: <Pine.LNX.4.33L2.0210241350230.20950-100000@dragon.pdx.osdl.net> <Pine.LNX.4.33.0210241839490.10937-100000@rancor.yyz.somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210241839490.10937-100000@rancor.yyz.somanetworks.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 07:00:23PM -0400, Scott Murray wrote:
> 
> I've not implemented it yet, but I'm pretty sure I can detect surprise
> extractions in my cPCI driver.  The only thing holding me back at the
> moment is that there's no clear way to report this status change via
> pcihpfs without doing something a bit funky like reporting "-1" in the
> "adapter" node.

Why would you need to report anything other than if the card is present
or not?  What would a "supprise" removal cause you to do differently?
Hm, well I guess we should be extra careful in trying to shut down any
driver bound to that card...

thanks,

greg k-h
