Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261363AbTCVAVr>; Fri, 21 Mar 2003 19:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261403AbTCVAVr>; Fri, 21 Mar 2003 19:21:47 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:42760 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261363AbTCVAVq>;
	Fri, 21 Mar 2003 19:21:46 -0500
Date: Fri, 21 Mar 2003 16:32:51 -0800
From: Greg KH <greg@kroah.com>
To: Junfeng Yang <yjf@stanford.edu>, linux-kernel@vger.kernel.org,
       mc@cs.stanford.edu
Subject: Re: [CHECKER] potential dereference of user pointer errors
Message-ID: <20030322003251.GA18359@kroah.com>
References: <200303041112.h24BCRW22235@csl.stanford.edu> <Pine.GSO.4.44.0303202226230.24869-100000@elaine24.Stanford.EDU> <20030321161550.D646@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030321161550.D646@figure1.int.wirex.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 04:15:50PM -0800, Chris Wright wrote:
> * Junfeng Yang (yjf@stanford.edu) wrote:
> > 
> > [MINOR] in debug data
> > 
> > /home/junfeng/linux-2.5.63/drivers/usb/serial/kobil_sct.c:429:kobil_write:
> > ERROR:TAINTED deferencing "buf" tainted by [dist=0][copy_from_user:parm1]
> 
> This is a bug, which could print kernel data if debugging was enabled.
> Greg, any reason the debug info can't just use the priv->buf?

Ugh, that's pretty bad.  That whole chunk of debug code should just be
replaced with a call to usb_serial_debug_data() like the other
usb-serial drivers do.

Patches welcomed :)

thanks,

greg k-h
