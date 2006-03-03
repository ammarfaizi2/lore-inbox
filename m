Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWCCMtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWCCMtd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 07:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWCCMtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 07:49:33 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:35216 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751196AbWCCMtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 07:49:32 -0500
Date: Fri, 3 Mar 2006 06:48:46 -0600
From: Robin Holt <holt@sgi.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adjust /dev/{kmem,mem,port} write handlers
Message-ID: <20060303124846.GA12112@lnx-holt.americas.sgi.com>
References: <44081B03.76F0.0078.0@novell.com> <1141378697.2883.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141378697.2883.39.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 10:38:17AM +0100, Arjan van de Ven wrote:
> On Fri, 2006-03-03 at 10:31 +0100, Jan Beulich wrote:
> > The /dev/mem and /dev/kmem write handlers weren't fully POSIX compliant in
> > that they wouldn't always force the file pointer to be updated when returning
> > success status.
> 
> should we instead just remove the /dev/mem and/or /dev/kmem write
> handlers entirely?

As long as I can still mmap offsets and write directly, I don't think
SGI will have any issue.  For diagnostics, SGI uses mmap of architecture
specific registers and injects errors to ensure signals get completely
through and processed correctly.  Of course, the last time I talked
with anybody about that stuff was more than a year ago and things may
have changed. I can ask around to see if anybody is using write, but I
would be very surprised.

Thanks,
Robin Holt
