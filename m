Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVAMR4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVAMR4U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVAMRzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:55:38 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:3036 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261278AbVAMRxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:53:52 -0500
Date: Thu, 13 Jan 2005 09:53:39 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
       pbadari@us.ibm.com, markv@us.ibm.com, gregkh@us.ibm.com,
       tytso@us.ibm.com, suparna@in.ibm.com
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050113175339.GE1269@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050107010119.GS1292@us.ibm.com> <20050113025157.GA2849@us.ibm.com> <1105601758.6031.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105601758.6031.6.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 08:35:58AM +0100, Arjan van de Ven wrote:
> On Wed, 2005-01-12 at 18:51 -0800, Paul E. McKenney wrote:
> > On Thu, Jan 06, 2005 at 05:01:19PM -0800, Paul E. McKenney wrote:
> > > On Thu, Jan 06, 2005 at 09:24:17PM +0000, Al Viro wrote:
> > > > "Use recursive bindings instead of trying to take over the entire mount tree
> > > > and mirroring it within your fs code.  And do that explicitly from userland".
> > > 
> > > Thank you for the pointer!  By this, you mean do mount operations in
> > > conjunction with namespaces, right?
> > > 
> > > I will follow up with more detail as I learn more.  The current issue
> > > seems to be with removeable devices.  Their users want to be accessing
> > > a particular version, but still see a memory stick that was subsequently
> > > mounted outside of the view.  Straightforward use of mounts and namespaces
> > > would prevent the memory stick from being visible to users that were
> > > already in view.
> > 
> > OK, after much thrashing, here is what the ClearCase users need.
> > Sorry for the length -- the first few paragraphs gives the flavor of
> > it and the rest goes into more detail with examples.
> > 
> > Thoughts?
> > 
> 
> Interesting; so clearcase mvfs currently extends the linux VFS to do all
> this.... It would be very interesting to get these extensions to linux
> posted on this mailing list in patch form, since it could well be a nice
> generic enhancement of linux. (Assuming Al doesn't go WTF over the code
> of course :-)

Just given the interfaces it makes use of, I would guess that Al would
more than go WTF over the current code.  Most would probably say that the
current code does not extend Linux VFS, but rather subverts it.  Plus it
was written by people without any history of Linux-kernel development,
so one would anticipate much heartburn over style and usage issues.  ;-)

All that aside, if you really really want to see it, I will see what I
can do about getting it to you.

							Thanx, Paul
