Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291868AbSBARYZ>; Fri, 1 Feb 2002 12:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291870AbSBARYP>; Fri, 1 Feb 2002 12:24:15 -0500
Received: from ns.caldera.de ([212.34.180.1]:13206 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S291868AbSBARYC>;
	Fri, 1 Feb 2002 12:24:02 -0500
Date: Fri, 1 Feb 2002 18:23:54 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] kthread abstraction
Message-ID: <20020201182354.A7740@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020201163818.A32551@caldera.de> <3C5ACE88.1050002@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C5ACE88.1050002@us.ibm.com>; from haveblue@us.ibm.com on Fri, Feb 01, 2002 at 09:21:12AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 09:21:12AM -0800, Dave Hansen wrote:
> Have you noticed that a lot of kernel daemons hold the BKL whenever 
> they're active?

I've seen it a few times.

> Things like nfsd are always holding the BKL, only 
> releasing it on schedule(), and exit.  Is there any compelling reason to 
> hold the BKL during times other than during the daemonize() process?

In general there is no reason.  If the data the thread accesses is not
protected by anything but BKL it must hold it - else it seems superflous
to me.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
