Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263041AbVAFVlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbVAFVlZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 16:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbVAFVjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 16:39:04 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:697 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263043AbVAFVhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 16:37:00 -0500
Date: Thu, 6 Jan 2005 13:35:52 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>,
       Mike Waychison <Michael.Waychison@Sun.COM>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
       pbadari@us.ibm.com, markv@us.ibm.com,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050106213552.GA11884@kroah.com>
References: <20050106190538.GB1618@us.ibm.com> <20050106191355.GA23345@infradead.org> <41DDA10F.6010805@sun.com> <20050106205931.GA25043@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106205931.GA25043@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 08:59:31PM +0000, Christoph Hellwig wrote:
> > Well, autofsng patches (new set forthcoming) use set_fs_root/set_fs_pwd
> > to pivot a call_usermodehelper process into the triggering process's
> > namespace.
> 
> Once we get anywhere where this is needed we'll find a better interface
> for that.  Like call_usermodehelper_in_namespace() or something even
> better.

Ah, a function like that would be nice to help with some issues that I
imagine the virtual-linux (or whatever that patch is called) people will
be having with udev and hotplug.  But as they haven't complained yet, I
haven't been very moved to look into it...

thanks,

greg k-h
