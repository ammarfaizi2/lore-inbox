Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264021AbTEFSYK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264022AbTEFSYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:24:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53387 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264021AbTEFSYG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:24:06 -0400
Message-ID: <3EB800B4.40204@pobox.com>
Date: Tue, 06 May 2003 14:36:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: Andrew Morton <akpm@digeo.com>, Nicolas <linux@1g6.biz>,
       linux-kernel@vger.kernel.org
Subject: Re: oops 2.5.68 ohci1394/ IRQ/acpi
References: <F760B14C9561B941B89469F59BA3A84725A28E@orsmsx401.jf.intel.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A28E@orsmsx401.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew wrote:
> Ohhh so we need to not just return nonzero, but return 1 (aka
> IRQ_HANDLED?) Well, then this makes sense. Sorry about that.
> 
> btw I think the line in handle_IRQ_event that reads
> 
> if (retval != 1) {
> 
> should be
> 
> if (retval != IRQ_HANDLED) {


Then I must further nit-pick:  if IRQ_HANDLED is considered "non-zero" 
the above test should be against IRQ_NONE, to avoid directly considering 
any single value _the_ non-zero value...

	Jeff



