Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVA0UOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVA0UOf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVA0UOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:14:35 -0500
Received: from canuck.infradead.org ([205.233.218.70]:23054 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261157AbVA0UNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:13:10 -0500
Subject: Re: Patch 0/6  virtual address space randomisation
From: Arjan van de Ven <arjan@infradead.org>
To: Julien TINNES <julien.tinnes.NOSPAM@francetelecom.REMOVE.com>
Cc: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org
In-Reply-To: <41F9425A.2030101@francetelecom.REMOVE.com>
References: <20050127101117.GA9760@infradead.org>
	 <41F8D44D.9070409@francetelecom.REMOVE.com>
	 <1106827050.5624.81.camel@laptopd505.fenrus.org>
	 <41F927F2.2080100@comcast.net>  <41F9425A.2030101@francetelecom.REMOVE.com>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 21:13:04 +0100
Message-Id: <1106856785.5624.132.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-27 at 20:34 +0100, Julien TINNES wrote:
> > 
> > Yeah, if it came from PaX the randomization would actually be useful.
> > Sorry, I've just woken up and already explained in another post.
> > 
> 
> Please, no hard feelings.
> 
> Speaking about implementation of the non executable pages semantics on 
> IA32, PaX and Exec-Shield are very different (well not that much since 
> 2.6 in fact because PAGEEXEC is now "segmentation when I can").
> But when it comes to ASLR it's pretty much the same thing.
> 
> The only difference may be the (very small) randomization of the brk() 
> managed heap on ET_EXEC (which is probably the more "hackish" feature of 
> PaX ASLR) but it seems that Arjan is even going to propose a patch for 
> that (Is this in ES too ?).

Exec shield randomized brk() too yes.
However that is a both more dangerous and more invasive change to do
correctly (you have no idea how hard it is to get that right for
emacs...) so that's reserved for the second batch of patches once this
first batch is dealt with.


