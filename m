Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVAGW4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVAGW4j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVAGW4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:56:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:45256 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261688AbVAGWxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:53:34 -0500
Date: Fri, 7 Jan 2005 14:58:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: mingo@elte.hu, viro@parcelfarce.linux.theplanet.co.uk, paulmck@us.ibm.com,
       arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, torvalds@osdl.org
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-Id: <20050107145801.64d55cd3.akpm@osdl.org>
In-Reply-To: <20050107221905.GA17567@infradead.org>
References: <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
	<20050106210408.GM1292@us.ibm.com>
	<20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk>
	<20050106152621.395f935e.akpm@osdl.org>
	<20050106234123.GA27869@infradead.org>
	<20050106162928.650e9d71.akpm@osdl.org>
	<20050107002624.GA29006@infradead.org>
	<20050107090014.GA24946@elte.hu>
	<20050107091542.GA5295@infradead.org>
	<20050107140034.46aec534.akpm@osdl.org>
	<20050107221905.GA17567@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Jan 07, 2005 at 02:00:34PM -0800, Andrew Morton wrote:
> > No, I'd say that unexports are different.  They can clearly break existing
> > code and so should only be undertaken with caution, and with lengthy notice
> > if possible.
> 
> As mentioned before we only unexported symbols were we were pretty clear
> that all users of it are indeep utterly broken.  I got about a dozend
> replies for this patches, and for more than half of it where the reporter
> was either the author or the module was opensource I could help them to
> actually fix their code.  In this case the code is far more broken than
> the others, but we've even been trying to help them fix their code for
> more than a year, but IBM folks have been constanly refusing.

They didn't fix their code because it worked - no reason to do so.

Telling people "this is going away in 12 months" gives them reason to fix
the code.  And a reasonable amount of time to do so and to distribute the
new version.

> > The cost to us of maintaining those two lines of code for a year is
> > basically zero.
> 
> But as long as IBM people don't fix their %$^%! they'll continue annoying
> us and the Distibutors about adding more and more hacks for it,

Maybe, maybe not.  But is it appropriate for us to be trying to control
someone else's internal activities via alterations to the kernel?

> and other
> people will write similarly crappy code using it again and making the
> removal even more difficult. 

I doubt if people would be silly enough to use a deprecated export in new
code after the export has been scheduled for removal.  If they do then yes,
sorry, we have to draw the line somewhere.

You still have not demonstrated any benefit to any party from not delaying
the removal of these two exports.
