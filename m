Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264502AbUEMTkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUEMTkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUEMTjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:39:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:39628 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264518AbUEMTfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:35:12 -0400
Date: Thu, 13 May 2004 12:35:09 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, hch@infradead.org,
       linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.6.6-mm2
Message-ID: <20040513123509.I21045@build.pdx.osdl.net>
References: <20040513032736.40651f8e.akpm@osdl.org> <20040513114520.A8442@infradead.org> <20040513035134.2e9013ea.akpm@osdl.org> <20040513121850.B22989@build.pdx.osdl.net> <20040513122940.0d281f52.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040513122940.0d281f52.akpm@osdl.org>; from akpm@osdl.org on Thu, May 13, 2004 at 12:29:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Chris Wright <chrisw@osdl.org> wrote:
> > What about something that's just simple and generic?  This is similar to
> > Andrea's disable_cap_mlock patch and the disabling capabilities patch
> > that wli produced back in that thread.  It would remove the hack, and
> > buy us some time to find better solutions.  Downside of course (as all
> > of these have) is reduced security value.
> 
> -ENODOCCO.

Oops, I assumed the MODULE_PARAM_DESC was self-explanatory for a first
pass, sorry about that.

> I assume one does
> 
> 	modprobe capability mask=32768
> 
> and this squashes CAP_IPC_LOCK system-wide?

Yes, although I think you picked off the wrong bit ;-)  (and I prefer hex)

	modprobe capability mask=0x4000

or if CONFIG_SECURITY_MODULE=y, then boot param:

	capability.mask=0x4000

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
