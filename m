Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWDNOnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWDNOnD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 10:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWDNOnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 10:43:03 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41405 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964872AbWDNOnC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 10:43:02 -0400
Subject: Re: Direct writing to the IDE on panic?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0604141023240.11098@gandalf.stny.rr.com>
References: <1144936547.1336.20.camel@localhost.localdomain>
	 <1145024914.17531.21.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0604141023240.11098@gandalf.stny.rr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 14 Apr 2006 15:52:07 +0100
Message-Id: <1145026327.17531.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-04-14 at 10:27 -0400, Steven Rostedt wrote:
> Nice point.  But fortunately, this is for a custom application running on
> an embedded device, such that the data that is on another part of the disk
> (which btw is an IDE flash) is just the application and the rest of the
> OS.  So, although a bad write to the disk will cause much more work, it
> wont destroy data that cant be replaced.

If you know the controller as well then you are correct in assuming the
code to do the dump is very simple indeed providing you stick to PIO,
especially if you know the set up is already done before crash

