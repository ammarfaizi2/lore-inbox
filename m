Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269109AbUJKPXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269109AbUJKPXk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268775AbUJKPSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:18:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19875 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268767AbUJKPRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:17:18 -0400
Subject: Re: Fw: signed kernel modules?
From: David Woodhouse <dwmw2@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: "Rusty Russell (IBM)" <rusty@au1.ibm.com>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <10345.1097507482@redhat.com>
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
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Red Hat UK Ltd.
Message-Id: <1097507755.318.332.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 11 Oct 2004 16:15:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 16:11 +0100, David Howells wrote:
> > Sign the whole thing.  Use a signature format which doesn't suck (ASN1
> > parsing in the kernel?  Hmm...).  Have your build system spit out two
> > RPMs, one with full debug modules, and one without.  This is not rocket
> > science.
> 
> You make it sound so simple...
> 
> I've adapted my patches to sign the whole thing

Why on earth would you want to sign the whole thing? As you've observed,
that means the signature gets broken when the debug info is stripped,
etc. Sign just what the kernel actually _looks_ at, nothing more.

Signing the whole thing is just silly. If you're going to include random
extra irrelevant stuff like comment sections and debug info, then you
might as well include the inode number and device on which the .ko file
is stored too -- so it breaks when you 'cp' it. 

>  'cos I know you're just going to fight it otherwise[*]:-)

 <...>

> [*] You're still wrong, of course, but that's your prerogative:-)

That doesn't mean you have to pander to him.

-- 
dwmw2
