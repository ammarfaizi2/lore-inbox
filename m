Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261485AbTCVAGD>; Fri, 21 Mar 2003 19:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbTCVAGC>; Fri, 21 Mar 2003 19:06:02 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:14331 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S261485AbTCVAGB>; Fri, 21 Mar 2003 19:06:01 -0500
Date: Fri, 21 Mar 2003 16:15:50 -0800
From: Chris Wright <chris@wirex.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, greg@kroah.com
Subject: Re: [CHECKER] potential dereference of user pointer errors
Message-ID: <20030321161550.D646@figure1.int.wirex.com>
Mail-Followup-To: Junfeng Yang <yjf@stanford.edu>,
	linux-kernel@vger.kernel.org, mc@cs.stanford.edu, greg@kroah.com
References: <200303041112.h24BCRW22235@csl.stanford.edu> <Pine.GSO.4.44.0303202226230.24869-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.44.0303202226230.24869-100000@elaine24.Stanford.EDU>; from yjf@stanford.edu on Thu, Mar 20, 2003 at 10:33:45PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Junfeng Yang (yjf@stanford.edu) wrote:
> 
> [MINOR] in debug data
> 
> /home/junfeng/linux-2.5.63/drivers/usb/serial/kobil_sct.c:429:kobil_write:
> ERROR:TAINTED deferencing "buf" tainted by [dist=0][copy_from_user:parm1]

This is a bug, which could print kernel data if debugging was enabled.
Greg, any reason the debug info can't just use the priv->buf?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
