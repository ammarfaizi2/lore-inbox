Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317393AbSGIURB>; Tue, 9 Jul 2002 16:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317397AbSGIURB>; Tue, 9 Jul 2002 16:17:01 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:13331 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317393AbSGIURA>;
	Tue, 9 Jul 2002 16:17:00 -0400
Date: Tue, 9 Jul 2002 13:17:03 -0700
From: Greg KH <greg@kroah.com>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
Message-ID: <20020709201703.GC27999@kroah.com>
References: <20020709043857.GA24418@kroah.com> <200207091931.g69JVD417360@eng4.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207091931.g69JVD417360@eng4.beaverton.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 11 Jun 2002 18:21:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2002 at 12:31:13PM -0700, Rick Lindsley wrote:
> Unless a developer is relying on the release-on-sleep mechanism or the
> nested-locks-without-deadlock mechanism, there's no reason an instance
> of the BKL can't be replaced with another spinlock.

Um, not true.  You can call schedule with the BKL held, not true for a
spinlock.

And see the oft repeated messages on lkml about the spinlock/semaphore
hell that some oses have turned into when they try to do this.  Let's
learn from history this time around please.

greg k-h
