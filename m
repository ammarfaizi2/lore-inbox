Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWHGWKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWHGWKG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 18:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWHGWKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 18:10:05 -0400
Received: from aa001msr.fastwebnet.it ([85.18.95.64]:63116 "EHLO
	aa001msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751133AbWHGWKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 18:10:04 -0400
Date: Tue, 8 Aug 2006 00:09:27 +0200
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, pavel@suse.cz,
       linux-pm@osdl.org
Subject: Re: resume from S3 regression [Was: 2.6.18-rc3-mm2]
Message-ID: <20060807220927.GA4946@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <20060807193836.GA4007@inferi.kami.home> <20060807130208.94b58773.akpm@osdl.org> <20060807205708.GC4007@inferi.kami.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807205708.GC4007@inferi.kami.home>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.18-rc3-mm2-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 10:57:08PM +0200, Mattia Dongili wrote:
> On Mon, Aug 07, 2006 at 01:02:08PM -0700, Andrew Morton wrote:
> > On Mon, 7 Aug 2006 21:38:36 +0200
> > Mattia Dongili <malattia@linux.it> wrote:
> > 
> > > after resume from ram (tested in single user), I can type commands for a
> > > few seconds (time is variable), the processes get stuck in io_schedule.
> > > Poorman's screenshots are here:
> > > http://oioio.altervista.org/linux/dsc03448.jpg
> > > http://oioio.altervista.org/linux/dsc03449.jpg
> > 
> > That probably measn that the device or device driver has got itself into a
> > sick state and IO completions aren't occurring. 
> 
> BTW: I tried to reverse ide-reprogram-disk-pio-timings-on-resume.patch
> with no luck.

reverting git-block.patch (plus a couple more to make the thing build)
let me resume correctly (2 cycles already).

Suggestion taken from the "swsusp regression" sub-thread.

-- 
mattia
:wq!
