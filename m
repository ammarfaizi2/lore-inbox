Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbTDOQIh (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 12:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbTDOQIh 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 12:08:37 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62911
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261711AbTDOQIf (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 12:08:35 -0400
Subject: Re: oops when using hdc=ide-scsi (2.5.66)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: davidsen@tmr.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030415085202.493ee48a.rddunlap@osdl.org>
References: <1049740232.2965.80.camel@dhcp22.swansea.linux.org.uk>
	 <Pine.LNX.3.96.1030415002500.22538A-100000@gatekeeper.tmr.com>
	 <20030415090357.5d5586b4.skraw@ithnet.com>
	 <20030415085202.493ee48a.rddunlap@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050420070.27745.54.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Apr 2003 16:21:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-15 at 16:52, Randy.Dunlap wrote:
> | > Is that an official position that it will not be supported? People with MO
> | > drives and tape will be supported only on 2.4?
> 
> Alan, if someone is willing to spend some time on ide-scsi, can you
> give hints about where to start, what to do?

Sure. Basically someone rewrote all the abort and reset code. It just
needs rewriting again so it works. Right now we have old-scsi/new-ide for 2.4
and new-scsi/old-ide-somewhat borked for 2.5.

The core reset code is now believed debugged so it should be possible to
fix ide-scsi.

