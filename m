Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317409AbSGIU7T>; Tue, 9 Jul 2002 16:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317410AbSGIU7S>; Tue, 9 Jul 2002 16:59:18 -0400
Received: from holomorphy.com ([66.224.33.161]:45964 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317409AbSGIU7R>;
	Tue, 9 Jul 2002 16:59:17 -0400
Date: Tue, 9 Jul 2002 14:00:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, Dave Hansen <haveblue@us.ibm.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
Message-ID: <20020709210053.GF25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rick Lindsley <ricklind@us.ibm.com>, Greg KH <greg@kroah.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	kernel-janitor-discuss <kernel-janitor-discuss@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <20020709201703.GC27999@kroah.com> <200207092055.g69Ktt418608@eng4.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <200207092055.g69Ktt418608@eng4.beaverton.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2002 at 01:55:55PM -0700, Rick Lindsley wrote:
> Well, this is what I meant by the release-on-sleep.  When you go to
> sleep, the BKL is actually released in the scheduler.
> Anything which is relying on this behavior needs to be redesigned.  It

This is an ugly aspect. But AFAICT the most that's needed to clean it
up is an explicit release before potentially sleeping.


Cheers,
Bill
