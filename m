Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317639AbSGOVLQ>; Mon, 15 Jul 2002 17:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317640AbSGOVLP>; Mon, 15 Jul 2002 17:11:15 -0400
Received: from 216-42-72-142.ppp.netsville.net ([216.42.72.142]:9562 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S317639AbSGOVLP>; Mon, 15 Jul 2002 17:11:15 -0400
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
From: Chris Mason <mason@suse.com>
To: "Patrick J. LoPresti" <patl@curl.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <s5gsn2kst2j.fsf@egghead.curl.com>
References: <20020712162306$aa7d@traf.lcs.mit.edu>
	<s5gsn2lt3ro.fsf@egghead.curl.com> <20020715173337$acad@traf.lcs.mit.edu> 
	<s5gsn2kst2j.fsf@egghead.curl.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 15 Jul 2002 17:14:36 -0400
Message-Id: <1026767676.4751.499.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-15 at 15:13, Patrick J. LoPresti wrote:

> > 1) that newly grown file is someone's inbox, and the old contents of the
> > new block include someone else's private message.
> >
> > 2) That newly grown file is a control file for the application, and the
> > application expects it to contain valid data within (think sendmail).  
> 
> In a correctly-written application, neither of these things can
> happen.  (See my earlier message today on fsync() and MTAs.)  To get a
> file onto disk reliably, the application must 1) flush the data, and
> then 2) flush a "validity" indicator.  This could be a sequence like:
> 
>   create temp file
>   flush data to temp file
>   rename temp file
>   flush rename operation

Yes, most mtas do this for queue files, I'm not sure how many do it for
the actual spool file.  mail server authors are more than welcome to
recommend the best safety/performance combo for their product, and to
ask the FS guys which combinations are safe.

-chris


