Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263829AbTDNT6K (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263839AbTDNT6K (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:58:10 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:56722 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263829AbTDNT6J (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 15:58:09 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] /sbin/hotplug multiplexor
Date: Mon, 14 Apr 2003 22:09:56 +0200
User-Agent: KMail/1.5
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20030414190032.GA4459@kroah.com> <200304142116.45303.oliver@neukum.org> <20030414195438.GA4952@kroah.com>
In-Reply-To: <20030414195438.GA4952@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304142209.56506.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 14. April 2003 21:54 schrieb Greg KH:
> On Mon, Apr 14, 2003 at 09:16:45PM +0200, Oliver Neukum wrote:
> > > Any objections or comments?  If not, I'll make the changes in the
> > > linux-hotplug project and release a new version based on this.
> >
> > Yes, consider what this does if you connect to a FibreChannel
> > grid. You are pushing system load by at least an order of magnitude.
>
> When you add a FibreChannel grid, the devices are discovered in
> sequential order, with SCSI IO happening between each device discovered.
> In talking to the SCSI people, that should be about 30ms per device
> found at the quickest.  So there's no /sbin/hotplug process storm :)
>
> And even if there is, we have to be able to handle such a load under
> normal situations anyway :)

Well, plugging them in is one case. But what is plugged in, will
eventually be unplugged as well. That will not require probing.

Now let's be conservative and assume 16KB unswappable memory
per task. Now we take the famous 4000 disk case. 64MB. A lot
but probably not deadly. But multiply this by 15 and the machine is
absolutely dead.

	Regards
		Oliver


