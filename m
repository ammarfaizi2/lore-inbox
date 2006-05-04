Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWEDMjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWEDMjD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 08:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWEDMjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 08:39:02 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:56529 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932296AbWEDMjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 08:39:00 -0400
Message-ID: <346744890.14268@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 4 May 2006 20:14:54 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Ph. Marek" <philipp.marek@bmlv.gv.at>, Linus Torvalds <torvalds@osdl.org>,
       Linda Walsh <lkml@tlinx.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-ID: <20060504121454.GB6008@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Arjan van de Ven <arjan@infradead.org>,
	"Ph. Marek" <philipp.marek@bmlv.gv.at>,
	Linus Torvalds <torvalds@osdl.org>, Linda Walsh <lkml@tlinx.org>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
	Badari Pulavarty <pbadari@us.ibm.com>
References: <346556235.24875@ustc.edu.cn> <44594AA9.8020906@tlinx.org> <Pine.LNX.4.64.0605031829300.4086@g5.osdl.org> <200605040908.10727.philipp.marek@bmlv.gv.at> <1146728004.3101.17.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146728004.3101.17.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2006 at 09:33:24AM +0200, Arjan van de Ven wrote:
> 
> 
> > Ascending block numbers on disk can be read very fast, as the disk needs no or 
> > less seeking. That's even true for stripes and mirrors. (I grant you that 
> > there are complicated setups out there, but these could be handled similar.)
> > 
> 
> 
> btw this all really spells out that you may want to do this as a device
> mapper thing; eg have a device mapper module that can do "lookaside" to
> a different order/mirror block whatever. The filesystem just doesn't
> want to know; do it at the DM level ;) That also solves the entire
> caching layering problem etc ;)

I guess some big corps might want to install such a layer into their
storage products ;)
