Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVAOA72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVAOA72 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVAOA4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:56:02 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:27077 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262078AbVAOAyC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:54:02 -0500
Date: Fri, 14 Jan 2005 16:50:01 -0800
From: Greg KH <greg@kroah.com>
To: Tom Zanussi <zanussi@comcast.net>
Cc: Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH 4/4] relayfs for 2.6.10: headers
Message-ID: <20050115005001.GB9046@kroah.com>
References: <41E736C4.3080806@opersys.com> <20050114191013.GB15337@kroah.com> <41E8282F.8060208@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E8282F.8060208@comcast.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 02:14:39PM -0600, Tom Zanussi wrote:
> Greg KH wrote:
> >On Thu, Jan 13, 2005 at 10:04:36PM -0500, Karim Yaghmour wrote:
> >
> >>+/**
> >>+ *	have_cmpxchg - does this architecture have a cmpxchg?
> >>+ *
> >>+ *	Returns 1 if this architecture has a cmpxchg useable by
> >>+ *	the lockless scheme, 0 otherwise.
> >>+ */
> >>+static inline int
> >>+have_cmpxchg(void)
> >>+{
> >>+#if defined(__HAVE_ARCH_CMPXCHG)
> >>+	return 1;
> >>+#else
> >>+	return 0;
> >>+#endif
> >>+}
> >
> >
> >Shouldn't this be a build time check, and not a runtime one?
> >
> 
> This was to avoid having an ifdef in the main body of the code.  It's 
> only used in channel setup, so I did'nt worrry about runtime checking.

This should all be set up properly for you anyway.  I don't think this
is needed at all.

thanks,

greg k-h
