Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268249AbUIKR06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268249AbUIKR06 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268210AbUIKRZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:25:57 -0400
Received: from open.hands.com ([195.224.53.39]:62876 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S268234AbUIKRZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:25:41 -0400
Date: Sat, 11 Sep 2004 18:36:52 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Cc: Patrick McHardy <kaber@trash.net>, linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: [PATCH 2.6 NETFILTER] new netfilter module ipt_program.c
Message-ID: <20040911173651.GC12835@lkcl.net>
References: <20040911124106.GD24787@lkcl.net> <4142F4CC.7080708@trash.net> <1094914175.8495.66.camel@sherbert>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094914175.8495.66.camel@sherbert>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 03:49:35PM +0100, Gianni Tedesco wrote:
> On Sat, 2004-09-11 at 14:51 +0200, Patrick McHardy wrote:
> > Luke Kenneth Casson Leighton wrote:
> > > decided to put this into a separate module.  based on ipt_owner.c.
> > > does full program's pathname.  like ipt_owner, only suitable for
> > > outgoing connections.
> > 
> > I agree that it would be useful to match the full path, but
> > the patch is broken, as are the owner match's pid-, sid- and
> > command-matching options. You can't grab files->file_lock
> > outside of process context. Besides, we want to consolidate
> > functionality, not add new matches that do basically the same
> > as existing ones.
> 
> This is a binary compatibility issue, I don't think it's possible to add
> Lukes functionality to ipt_owner without breaking iptables
> compatibility.
 
 weeeelllll... there's nothing to stop you adding a header file
 ipt_owner_program.h instead :)

 i know it breaks the convention but hey.

 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

