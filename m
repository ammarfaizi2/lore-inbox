Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbVJKN6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbVJKN6F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 09:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbVJKN6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 09:58:04 -0400
Received: from ns.firmix.at ([62.141.48.66]:51367 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751310AbVJKN6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 09:58:03 -0400
Subject: Re: [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
From: Bernd Petrovitsch <bernd@firmix.at>
To: Chris Wright <chrisw@osdl.org>
Cc: Harald Welte <laforge@gnumonks.org>, Linus Torvalds <torvalds@osdl.org>,
       Sergey Vlasov <vsu@altlinux.ru>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, security@linux.kernel.org,
       vendor-sec@lst.de
In-Reply-To: <20051010180745.GT5856@shell0.pdx.osdl.net>
References: <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org>
	 <20050927165206.GB20466@master.mivlgu.local>
	 <Pine.LNX.4.58.0509270959380.3308@g5.osdl.org>
	 <20050930104749.GN4168@sunbeam.de.gnumonks.org>
	 <Pine.LNX.4.64.0509300752530.3378@g5.osdl.org>
	 <20050930184433.GF16352@shell0.pdx.osdl.net>
	 <Pine.LNX.4.64.0509301225190.3378@g5.osdl.org>
	 <20050930220808.GE4168@sunbeam.de.gnumonks.org>
	 <Pine.LNX.4.64.0509301514190.3378@g5.osdl.org> <20051010174429.GH5627@rama>
	 <20051010180745.GT5856@shell0.pdx.osdl.net>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Tue, 11 Oct 2005 15:57:19 +0200
Message-Id: <1129039039.16614.26.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-10 at 11:07 -0700, Chris Wright wrote:
> * Harald Welte (laforge@gnumonks.org) wrote:
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -1193,6 +1193,40 @@ kill_proc_info(int sig, struct siginfo *
> >  	return error;
> >  }
> >  
> > +/* like kill_proc_info(), but doesn't use uid/euid of "current" */
> 
> Maybe additional comment reminding that you most likely don't want this
> interface.

Just mark it DEPRECATED since it basically is that?!

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

