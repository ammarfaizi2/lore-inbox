Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVCUOqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVCUOqE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 09:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVCUOqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 09:46:04 -0500
Received: from [81.2.110.250] ([81.2.110.250]:29906 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261809AbVCUOp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 09:45:59 -0500
Subject: Re: 2.6.11 AC patch CD/DVD issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: takisd@alphalink.com.au
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1111332446.8418.47.camel@localhost>
References: <1111332446.8418.47.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1111416216.14877.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 21 Mar 2005 14:43:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-03-20 at 15:27, Takis Diakoumis wrote:
> other ata controllers which then report errors as they can't be unloaded
> - though i read somewhere on this list that this was by design???).

IDE is designed to be compiled in. There is a lot to do to fix that. -ac
has hackish unload support in test but the right solution is refcounting
and driver model based and is in Bartlomiej's dev tree.

> all cd ripping/reading tools for audio/multimedia cds report unable to
> initialize /dev/cdrom (a link to cdrom device).

Are you sure it points to the right device. I've seen similar reports
where
/dev/cdrom ended up pointing at the hard disk when the it8212 is added.
Seems
some distributions get confused when an IDE controller decides it wants
to be first.

> mode anyway. no change with either setting. if i disable the controller
> from the bios, all is ok and i have full expected access to both cd and
> dvd drives with all tools/apps etc. enabling again, i lose them beyond
> simple data mounts.

Sounds like the /dev/cdrom link is wrong


