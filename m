Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbTEHONO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 10:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbTEHONN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 10:13:13 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:25093 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261580AbTEHONI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 10:13:08 -0400
Date: Thu, 8 May 2003 15:25:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Terje Malmedal <terje.malmedal@usit.uio.no>
Cc: hch@infradead.org, alan@lxorguk.ukuu.org.uk, terje.eggestad@scali.com,
       arjanv@redhat.com, linux-kernel@vger.kernel.org, D.A.Fedorov@inp.nsk.su
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030508152543.A6895@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Terje Malmedal <terje.malmedal@usit.uio.no>,
	alan@lxorguk.ukuu.org.uk, terje.eggestad@scali.com,
	arjanv@redhat.com, linux-kernel@vger.kernel.org,
	D.A.Fedorov@inp.nsk.su
References: <20030508132931.A4951@infradead.org> <E19DlI5-00011n-00@aqualene.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E19DlI5-00011n-00@aqualene.uio.no>; from terje.malmedal@usit.uio.no on Thu, May 08, 2003 at 03:18:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 03:18:29PM +0200, Terje Malmedal wrote:
> And if I wish to help somebody running a kernel I didn't compile?

recompile it.  binary patch it.  I don't care.  Linux is free software
so you're allowed to change whatever you want.  Just don't annoy us
about fixing problems in mainline.

> Do you have anything constructive to say about situation i referred
> to:
> 
> A database is starting to run slower and slower, turns out that this
> is because fsync() is inefficient on large files. Rebooting the server
> or restarting the database is undesirable even at night.

fix the database.  hey, if you think it's so important fork the kernel.
if there's enough people that agree with you wour fork will be mainline
some day.  It's really _that_ easy.

> The only problem I can see is that different modules overloading the
> same function needs to be unloaded in the correct order. Is this the
> only reason for removing it, or am I missing something?

it's racy - and it doesn't work on half of the arches added over the
last years.

