Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268675AbUIBQ3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268675AbUIBQ3r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 12:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268703AbUIBQ3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 12:29:47 -0400
Received: from peabody.ximian.com ([130.57.169.10]:21709 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268675AbUIBQ2Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 12:28:24 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@ximian.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Daniel Stekloff <dsteklof@us.ibm.com>, Greg KH <greg@kroah.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040902132609.GB26413@vrfy.org>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
	 <20040831145643.08fdf612.akpm@osdl.org>
	 <1093989513.4815.45.camel@betsy.boston.ximian.com>
	 <20040831150645.4aa8fd27.akpm@osdl.org>
	 <1093989924.4815.56.camel@betsy.boston.ximian.com>
	 <20040902083407.GC3191@kroah.com>
	 <1094126565.1761.25.camel@localhost.localdomain>
	 <20040902132609.GB26413@vrfy.org>
Content-Type: text/plain
Date: Thu, 02 Sep 2004 12:27:49 -0400
Message-Id: <1094142469.2284.15.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 15:26 +0200, Kay Sievers wrote:

> o What kind of signal do we need? A lazy string, a well defined set like
>   ADD/REMOVE/CHANGE?
>   Or can we get rid of the whole signal? But how can we distinguish between
>   add and remove? Watching if the sysfs file comes or goes is not a option,
>   I think.

I think (from our off-list discussions) that we really need the signal.
Agreed?

I do think that defining the signal to specific values makes sense, e.g.
KEVENT_ADD, KEVENT_REMOVE, KEVENT_MOUNTED, etc.  We could also send the
attribute as a string.

To get around the hotplug issue that would occur without 'enum kevent',
as we discussed, we could have a "hotplug_added" signal or whatever.
Nothing wrong with that.

Cool or not?

	Robert Love


