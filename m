Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266298AbUFPOdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266298AbUFPOdG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 10:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266313AbUFPObf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 10:31:35 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:35757 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S266316AbUFPO2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 10:28:15 -0400
Message-ID: <40D058F3.5070109@nortelnetworks.com>
Date: Wed, 16 Jun 2004 10:28:03 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Sabharwal, Atul" <atul.sabharwal@intel.com>
CC: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Announce] Non Invasive Kernel Monitor for threads/processes
References: <66539F0E7F15B44C9C0FC50D0FF024F7B1A324@orsmsx407>
In-Reply-To: <66539F0E7F15B44C9C0FC50D0FF024F7B1A324@orsmsx407>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sabharwal, Atul wrote:

> How does auditing work in the event of a process failure ? There would
> be
> no system call triggered in that case.  Also, my initial thoughts are
> that the non-invasive Kmonitor is lesser performance impact when
> compared
> to auditing. I would spend some time developing sample code to confirm
> it.

Just to put in my $.02.  We developed a very simple (even simpler than Kmonitor 
in that it didn't track fork/exec) way for a process to get notified when other 
processes exited (properly or otherwise).  We want to use this in the field for 
a lifecycle monitoring function (a sort of super-init) so it needs to be as 
lightweight as possible.  I'd love to be able to use something from the mainline 
kernel, but it has to be field-runnable without slowing stuff down.

Chris
