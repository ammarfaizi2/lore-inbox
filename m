Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269301AbUJKWgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269301AbUJKWgV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269311AbUJKWgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:36:21 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:57549 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S269301AbUJKWfC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:35:02 -0400
Subject: Re: Fw: signed kernel modules?
From: "Rusty Russell (IBM)" <rusty@au1.ibm.com>
To: David Woodhouse <dwmw2@redhat.com>
Cc: David Howells <dhowells@redhat.com>, rusty@ozlabs.au.ibm.com,
       Greg KH <greg@kroah.com>, Arjan van de Ven <arjanv@redhat.com>,
       Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097507755.318.332.camel@hades.cambridge.redhat.com>
References: <1096544201.8043.816.camel@localhost.localdomain>
	 <1096411448.3230.22.camel@localhost.localdomain>
	 <1092403984.29463.11.camel@bach> <1092369784.25194.225.camel@bach>
	 <20040812092029.GA30255@devserv.devel.redhat.com>
	 <20040811211719.GD21894@kroah.com>
	 <OF4B7132F5.8BE9D947-ON87256EEB.007192D0-86256EEB.00740B23@us.ibm.com>
	 <1092097278.20335.51.camel@bach> <20040810002741.GA7764@kroah.com>
	 <1092189167.22236.67.camel@bach> <19388.1092301990@redhat.com>
	 <30797.1092308768@redhat.com>
	 <20040812111853.GB25950@devserv.devel.redhat.com>
	 <20040812200917.GD2952@kroah.com> <26280.1092388799@redhat.com>
	 <27175.1095936746@redhat.com> <30591.1096451074@redhat.com>
	 <10345.1097507482@redhat.com>
	 <1097507755.318.332.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Organization: IBM
Message-Id: <1097534090.16153.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 08:34:50 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 01:15, David Woodhouse wrote:
> On Mon, 2004-10-11 at 16:11 +0100, David Howells wrote:
> > > Sign the whole thing.  Use a signature format which doesn't suck (ASN1
> > > parsing in the kernel?  Hmm...).  Have your build system spit out two
> > > RPMs, one with full debug modules, and one without.  This is not rocket
> > > science.
> > 
> > You make it sound so simple...
> > 
> > I've adapted my patches to sign the whole thing
> 
> Why on earth would you want to sign the whole thing? As you've observed,
> that means the signature gets broken when the debug info is stripped,
> etc. Sign just what the kernel actually _looks_ at, nothing more.

Welcome to the debate David.  I agree that you only need to sign the
things that the kernel looks at, unfortunately, there's not a nice clear
line: for example the headers change when you strip the module, and they
need to be signed.

Trying to work around it just gets you into more and more complexity:
you can't trust the module until you've checked the signature, and when
you don't trust the module you have to write paranoid code, which is
very ugly and causes bloat.  David Howells just sidestepped this and
trusted the module headers, and so I refused his patch.

> > [*] You're still wrong, of course, but that's your prerogative:-)
> 
> That doesn't mean you have to pander to him.

Nor do I have to re-iterate the points from the discussion for someone
who hasn't bothered reading it.  But I did.

Rusty.


