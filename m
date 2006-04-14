Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWDNO1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWDNO1K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 10:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWDNO1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 10:27:09 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:47320 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964820AbWDNO1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 10:27:08 -0400
Date: Fri, 14 Apr 2006 10:27:05 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Direct writing to the IDE on panic?
In-Reply-To: <1145024914.17531.21.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0604141023240.11098@gandalf.stny.rr.com>
References: <1144936547.1336.20.camel@localhost.localdomain>
 <1145024914.17531.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Apr 2006, Alan Cox wrote:

>
> The big issue is 'how am I sure the partition data and code I run are
> valid post crash'. You don't want the risk of dumping to the wrong part
> of the disk and making a crash into a disaster.
>

Nice point.  But fortunately, this is for a custom application running on
an embedded device, such that the data that is on another part of the disk
(which btw is an IDE flash) is just the application and the rest of the
OS.  So, although a bad write to the disk will cause much more work, it
wont destroy data that cant be replaced.

Thanks,

-- Steve

