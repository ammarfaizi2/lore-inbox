Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbULQWPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbULQWPS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 17:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbULQWPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 17:15:18 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:58004 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262145AbULQWPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 17:15:08 -0500
Message-ID: <41C35A45.7090206@sgi.com>
Date: Fri, 17 Dec 2004 16:14:29 -0600
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6.10 Altix : ioc4 serial driver support
References: <200412162224.iBGMOQ52284713@fsgi900.americas.sgi.com> <20041216231519.GA16249@infradead.org>
In-Reply-To: <20041216231519.GA16249@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Thu, Dec 16, 2004 at 04:24:26PM -0600, Pat Gefre wrote:
> 
>>I have a serial driver for Altix I'd like to submit.
>>
>>The code is at:
>>ftp://oss.sgi.com/projects/sn2/sn2-update/033-ioc4-support
>>
>>Signed-off-by: Patrick Gefre <pfg@sgi.com>
> 
> 
> I took a very short look and what spring to mind first is that the
> device probing/remoal is rather bogus.  The ->probe/->remove callbacks
> of a PCI driver can be called at any time, and any initialization /
> teardown actions must happen from those.  A logical consequence of that
> is that a proper PCI driver should have no global state.
> 

Christoph,

I'm not sure what you mean here. I don't have an entry for ->remove and the driver is self-contained.

-- Pat
