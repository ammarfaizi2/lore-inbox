Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVAMSRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVAMSRI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 13:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVAMSO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 13:14:29 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:22415 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261369AbVAMSJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 13:09:24 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: 2.6.10-mm3: swsusp: out of memory on resume (was: Re: Ho ho ho - Linux v2.6.10)
Date: Thu, 13 Jan 2005 19:09:24 +0100
User-Agent: KMail/1.7.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org> <200412262127.49897.Rafal.Wysocki@fuw.edu.pl> <20041226221046.GA1406@elf.ucw.cz>
In-Reply-To: <20041226221046.GA1406@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501131909.26021.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just had one of those on 2.6.10-mm3:

On Sunday, 26 of December 2004 23:10, Pavel Machek wrote:
> Hi!
> 
> > > > Usually, it resumes sucessfully for me, but sometimes it fails, like this 
> > (on 
> > > > an AMD64):
> > > > 
> > > >  swsusp: Image: 43552 Pages
> > > >  swsusp: Pagedir: 341 Pages
> > > > pmdisk: Reading pagedir (341 Pages)
> > > > Relocating 
> > > > 
> > pagedir ...........................................................................................................................0
> > > > 
> > > > Call Trace:<ffffffff8016de7e>{__alloc_pages+766} 
> > > > <ffffffff8016df21>{__get_free_pages+33}
> > > >        <ffffffff8056191c>{swsusp_read+1020} 
> > > > <ffffffff8015f711>{software_resume+33}
> > > >        <ffffffff8010c142>{init+162} <ffffffff8010f57b>{child_rip+8}
> > > >        <ffffffff8010c0a0>{init+0} <ffffffff8010f573>{child_rip+0}
> > > > 
> > > > out of memory
> > > 
> > > ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::g
> > > > PM: Resume from disk failed.
> > > 
> > > Can you try this one? It would be nice to have reproducible way to
> > > trigger this before trying to fix it, through.
> > > 
> > > [Patch is for 2.6.9something+my bigdiff, may need small tweaks]
> > 
> > It's for i386, isn't it?  Will it work as expected on AMD64?
> 
> Ouch, no, it probably will not work on amd64. Some assembly tweaks
> would be needed.
> 
> Anyway here's that patch ported to 2.6.10+my_bigdiff (just in case
> anyone has the same problem on i386).

Has this patch been ported to x86_64?  Or is there a newer version of it anywhere,
or an alternative?

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
