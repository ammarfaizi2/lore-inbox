Return-Path: <linux-kernel-owner+w=401wt.eu-S932696AbWLNMdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbWLNMdL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 07:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932689AbWLNMdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 07:33:11 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37969 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932696AbWLNMdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 07:33:10 -0500
X-Greylist: delayed 1767 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 07:33:10 EST
Date: Thu, 14 Dec 2006 13:03:41 +0100
From: Jan Kara <jack@suse.cz>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 file content corruption on ext3
Message-ID: <20061214120341.GA17611@atrey.karlin.mff.cuni.cz>
References: <20061207155740.GC1434@torres.l21.ma.zugschlus.de> <4578465D.7030104@cfl.rr.com> <1165541892.1063.0.camel@sebastian.intellilink.co.jp> <20061208164206.GA1125@torres.l21.ma.zugschlus.de> <20061209104758.GA10261@atrey.karlin.mff.cuni.cz> <20061211190700.GA15165@torres.l21.ma.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211190700.GA15165@torres.l21.ma.zugschlus.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Dec 09, 2006 at 11:47:58AM +0100, Jan Kara wrote:
> >   In the mean time
> >   does mounting the filesystem with data=writeback help?
> 
> I have now nine hours uptime with data=writeback, and the file is
> still OK. Looks good.
> 
> By this posting, I'm going to invoke murphy, so I'll report again
> tomorrow.
  Since you haven't written till today I assume that data=writeback does
not have a problem. Hmm. I really start to suspect my changes to JBD
commit code. But I was trying to reproduce the problem by copying files
there and back without success :( Also I check the code and I don't see
how we could loose dirty bits on buffers (which is probably what happens
as one guy has written to me that he also sees the problem when using
rtorrent which does checksum after downloading and that passes fine).
Next I'm going to try to reproduce the problem with heavy mmap load.
Maybe that would trigger it.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
