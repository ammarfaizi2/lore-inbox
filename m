Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264345AbUD0Umg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264345AbUD0Umg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 16:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUD0Umg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 16:42:36 -0400
Received: from mail.gmx.de ([213.165.64.20]:18318 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264345AbUD0Ume (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 16:42:34 -0400
X-Authenticated: #1226656
Date: Tue, 27 Apr 2004 22:42:31 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Dru <andru@treshna.com>, linux-xfs@oss.sgi.com,
       =?ISO-8859-1?Q?M=E5ns_?= =?ISO-8859-1?Q?Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: status of Linux on Alpha?
Message-Id: <20040427224231.0e439344@vaio.gigerstyle.ch>
In-Reply-To: <20040428002018.A827@den.park.msu.ru>
References: <yw1xr7vcn1z2.fsf@ford.guide>
	<20040329205233.5b7905aa@vaio.gigerstyle.ch>
	<20040404121032.7bb42b35@vaio.gigerstyle.ch>
	<20040409134534.67805dfd@vaio.gigerstyle.ch>
	<20040409134828.0e2984e5@vaio.gigerstyle.ch>
	<20040409230651.A727@den.park.msu.ru>
	<20040413194907.7ce8ceb7@vaio.gigerstyle.ch>
	<20040427185124.134073cd@vaio.gigerstyle.ch>
	<20040427215514.A651@den.park.msu.ru>
	<20040427200830.3f485a54@vaio.gigerstyle.ch>
	<20040428002018.A827@den.park.msu.ru>
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004 00:20:18 +0400
Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:

> On Tue, Apr 27, 2004 at 08:08:30PM +0200, Marc Giger wrote:
> > I wonder why it happens only with the XFS code. What I saw
> > rw_sem is used all over the place in the kernel.
> 
> Dru says it happens with ext3 as well. XFS folks used their own
> locking code (which hasn't suffered from that bug) until 2.6.4,
> that's why you noticed the difference...

Yes, as I saw that the patch uses the semaphore code in "arch" I was
not sure any longer if it is really a XFS related bug.

> In either case, you need _really_ heavy write IO activity to
> trigger the bug.

I noticed that. The best way to trigger it was "make -j20 vmlinux"
so that the pdflushd comes strongly into action.

Perhaps Dru can show me his "easy way" to reproduce the problem so that
I can test it more easily.

Thanks again

Marc
