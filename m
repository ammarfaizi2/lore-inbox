Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUFJG3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUFJG3m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 02:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266182AbUFJG3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 02:29:41 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48314 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266189AbUFJG3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 02:29:13 -0400
Date: Thu, 10 Jun 2004 08:29:07 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org
Subject: Re: ide errors in 7-rc1-mm1 and later
Message-ID: <20040610062906.GG13836@suse.de>
References: <1085689455.7831.8.camel@localhost> <200405271928.33451.edt@aei.ca> <200406032207.25602.edt@aei.ca> <200406091944.15082.edt@aei.ca> <20040609165231.151e84e7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040609165231.151e84e7.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09 2004, Andrew Morton wrote:
> Ed Tomlinson <edt@aei.ca> wrote:
> >
> > Hi,
> > 
> > I am still seeing these with 7-rc3-mm1...  No extra diag info either.   I would be
> > really nice to see this one fixed.
> 
> So ide-print-failed-opcode.patch isn't working.  Presumably
> HWGROUP(drive)->rq is null.

No, I just put the code in the wrong ->error() location since ide has
dupes of this sprinkled...

I'll get you one for ide-disk that works. It could be handy in the
future as well, it's always annoyed me that ide errors without telling
you what command failed.

-- 
Jens Axboe

