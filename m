Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbVJXXJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbVJXXJl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 19:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbVJXXJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 19:09:40 -0400
Received: from qproxy.gmail.com ([72.14.204.205]:21048 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751360AbVJXXJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 19:09:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=bJRFlD1TMKo+QknVvYfLgY7Q006Ttz01BveGhcKu4nRcCJRbWmHg0fs1htXSXr/AYQxaTyDlStBsip5jn6NWOs5CZJvUPRroqfBM6ejEvJOiBx+GS92Qbs+QgIcV0EWciBHDsz7cInU6iB6ykJZukzBm253KDRTxipZ92QbTDf4=
Subject: Re: [PATCH] RCU torture-testing kernel module
From: Badari Pulavarty <pbadari@gmail.com>
To: paulmck@us.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, Ingo Oeser <ioe-lkml@rameria.de>,
       lkml <linux-kernel@vger.kernel.org>, arjan@infradead.org, pavel@ucw.cz,
       dipankar@in.ibm.com, vatsa@in.ibm.com, rusty@au1.ib.com, mingo@elte.hu,
       manfred@colorfullife.com, gregkh@kroah.com
In-Reply-To: <20051024225438.GE12812@us.ibm.com>
References: <20051022231214.GA5847@us.ibm.com>
	 <200510230922.26550.ioe-lkml@rameria.de> <20051023143617.GA7961@us.ibm.com>
	 <200510232055.17782.ioe-lkml@rameria.de>
	 <20051023120521.26031051.akpm@osdl.org> <20051024004709.GA9454@us.ibm.com>
	 <1130171073.6831.6.camel@localhost.localdomain>
	 <20051024225438.GE12812@us.ibm.com>
Content-Type: text/plain
Date: Mon, 24 Oct 2005 16:09:00 -0700
Message-Id: <1130195340.6831.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-24 at 15:54 -0700, Paul E. McKenney wrote:
> On Mon, Oct 24, 2005 at 09:24:33AM -0700, Badari Pulavarty wrote:
> > On Sun, 2005-10-23 at 17:47 -0700, Paul E. McKenney wrote:
> > > On Sun, Oct 23, 2005 at 12:05:21PM -0700, Andrew Morton wrote:
> > > > Ingo Oeser <ioe-lkml@rameria.de> wrote:
> > > > >
> > > > > DEBUG_KERNEL should do nothing more than showing the debugging
> > > > >  options. 
> > > > 
> > > > yup.
> > > > 
> > > > >  E.g. I don't expect to enable any additional code in an 
> > > > >  unrelated file, if I enable Magic-SysRQ on an embedded, unattended device
> > > > >  to be able to analyze potential problems via serial console.
> > > > > 
> > > > >  @Andrew: Would you accept a patch to fix that?
> > > > 
> > > > more yup.
> > > 
> > > OK, the attached patch covers this and also fixes the redundant #include
> > > that Greg KH spotted.
> > > 
> > > Thoughts?
> > 
> > Paul,
> > 
> > I enabled RCU_TORTURE_TEST in 2.6.14-rc5-mm1. My machine took 10+
> > minutes to boot and let me login. RCU kthreads are hogging the CPU. 
> > Is this expected ? 
> 
> If you did CONFIG_RCU_TORTURE_TEST=y, then yes.

Yep. I have a bad habit of saying "y" to all interesting stuff
in -mm kernel (while doing make oldconfig). I don't use "modules",
initrd etc..

I compiled it as a module. No harm done :)

Thanks,
Badari

