Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261949AbSJDSfN>; Fri, 4 Oct 2002 14:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261981AbSJDSfN>; Fri, 4 Oct 2002 14:35:13 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:25180 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261949AbSJDSfL>; Fri, 4 Oct 2002 14:35:11 -0400
Date: Fri, 4 Oct 2002 14:41:53 -0400
From: Doug Ledford <dledford@redhat.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx problems?
Message-ID: <20021004184153.GA1916@redhat.com>
Mail-Followup-To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
	linux-kernel@vger.kernel.org
References: <E50A0EFD91DBD211B9E40008C75B6CCA01497EDE@ES-STH-012> <367452704.1033669443@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367452704.1033669443@aslan.btc.adaptec.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 12:24:03PM -0600, Justin T. Gibbs wrote:
> >> Actually, in reviewing your message more fully, the problem is that
> >> the timeout for the rewind operation is too short for your 
> >> configuration.
> >> The timeout should go away if you bump up the timeout in the st driver
> >> so that your tape drive can rewind in peace.
> > 
> > The rewind is not *that* long, about 60 seconds...
> 
> Well, we are still waiting on the drive to do something, so its not
> the aic7xxx driver's fault.

It's possible that the controller could have disconnect disabled for the 
tape drive, causing it to hold the bus the entire time and making other 
commands time out (although unlikely unless someone actually went in and 
turned it off in the adapter config...)

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
