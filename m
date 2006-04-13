Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWDMKVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWDMKVg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 06:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWDMKVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 06:21:36 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41154 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964873AbWDMKVf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 06:21:35 -0400
Subject: Re: Tracking down leaking applications
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rahul Karnik <rahul@genebrew.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <b29067a0604090842h3bb11a88re9c175a467763c9f@mail.gmail.com>
References: <b29067a0604090842h3bb11a88re9c175a467763c9f@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Apr 2006 11:30:47 +0100
Message-Id: <1144924247.9989.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2006-04-09 at 11:42 -0400, Rahul Karnik wrote:
> The process killed has been either httpd or cronolog so far. For now,
> I have upgraded to FC4's 2.6.16-1_1069 and added some swap, where
> previously there was none.

Under load apache can want a lot of memory as you have a lot of server
processes compared to say thttpd or boa.

> Is there a way to:
> - confirm that it is a userspace and not a kernel issue?
> - track down the application that is leaking memory?

Apache allows you to control the memory usage of CGIs and also the
number of servers etc. That may be a good starting point for tuning. See
the apache docs and apacheweek

