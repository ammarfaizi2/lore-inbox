Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264191AbUD0Qvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264191AbUD0Qvp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 12:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbUD0Qvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 12:51:45 -0400
Received: from mail.gmx.de ([213.165.64.20]:60382 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264191AbUD0Qve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 12:51:34 -0400
X-Authenticated: #1226656
Date: Tue, 27 Apr 2004 18:51:24 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-xfs@oss.sgi.com,
       =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: status of Linux on Alpha?
Message-Id: <20040427185124.134073cd@vaio.gigerstyle.ch>
In-Reply-To: <20040413194907.7ce8ceb7@vaio.gigerstyle.ch>
References: <yw1xsmftnons.fsf@ford.guide>
	<20040328201719.A14868@jurassic.park.msu.ru>
	<yw1xoeqhndvl.fsf@ford.guide>
	<20040328204308.C14868@jurassic.park.msu.ru>
	<20040328221806.7fa20502@vaio.gigerstyle.ch>
	<yw1xr7vcn1z2.fsf@ford.guide>
	<20040329205233.5b7905aa@vaio.gigerstyle.ch>
	<20040404121032.7bb42b35@vaio.gigerstyle.ch>
	<20040409134534.67805dfd@vaio.gigerstyle.ch>
	<20040409134828.0e2984e5@vaio.gigerstyle.ch>
	<20040409230651.A727@den.park.msu.ru>
	<20040413194907.7ce8ceb7@vaio.gigerstyle.ch>
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What's the current status of the problem? Is nobody interested to fix
it, or am I just impatient? Did I provide not enough information?
I'm running 2.6.5 with the reverted patch for 2 weeks now without any
problems.

Regards

Marc

On Tue, 13 Apr 2004 19:49:07 +0200
Marc Giger <gigerstyle@gmx.ch> wrote:

> Hi Ivan, All
> 
> First, sorry for the cross posting...
> 
> After long sessions of patching, recompiling, and testing I finally
> found the cause of my problems. XFS people, please read:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108047692409817&w=2
> and
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107910319729364&w=2
> 
> After reverting 1.1608.29.12 all is fine again.
> Interestingly, this patch was listed on bkbits between 2.6.3
> and 2.6.4-rc1 but was added to the source tree between 2.6.4-rc1 and
> 2.6.4-rc2 :-( Again something learned for the future...
> 
> Ivan, I think your new semaphore code is still ok because it doesn't
> matter if it is the new or old code. Both versions have a problem with
> the xfs-patch.
> 
> For further questions you know how to reach me:-)
> 
> greets
> 
> Marc
> 
> 
> On Fri, 9 Apr 2004 23:06:51 +0400
> Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:
> 
> > On Fri, Apr 09, 2004 at 01:48:28PM +0200, Marc Giger wrote:
> > > > Presently, I reached a stage on which I don't know longer what
> > > > to do:-( I isolated the problem between 2.6.3-rc1 and 2.6.3-rc2.
> > > > I
> > >                                        ^^^^^^^^^^^^^^^^^^^^^^^
> > >                                read as 2.6.4-rc1 and 2.6.4-rc2
> > 
> > Thanks for your work.
> > 
> > > > also reverted 1.1608.56.1 , 1.1608.51.36 and all xfs related
> > > > patches from rc2 with no luck.
> > > > All other changes seems unrelated to me.
> > 
> > I'd also revert 1.1608.51.22 and all networking changes.
> > 
> > Ivan.
> > 
> 
> 
