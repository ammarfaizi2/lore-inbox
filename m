Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVGBQZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVGBQZu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 12:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVGBQZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 12:25:50 -0400
Received: from peabody.ximian.com ([130.57.169.10]:29902 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261206AbVGBQZo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 12:25:44 -0400
Subject: Re: Problem with inotify
From: Robert Love <rml@novell.com>
To: David =?ISO-8859-1?Q?G=F3mez?= <david@pleyades.net>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
       John McCutchan <ttb@tentacle.dhs.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050702125403.GA904@fargo>
References: <20050630181824.GA1058@fargo> <1120156188.6745.103.camel@betsy>
	 <20050630193320.GA1136@fargo>
	 <Pine.LNX.4.60.0506302138230.29755@hermes-1.csi.cam.ac.uk>
	 <20050630204832.GA3854@fargo>
	 <Pine.LNX.4.60.0506302158190.29755@hermes-1.csi.cam.ac.uk>
	 <1120249515.6745.177.camel@betsy>  <20050702125403.GA904@fargo>
Content-Type: text/plain; charset=utf-8
Date: Sat, 02 Jul 2005 12:25:43 -0400
Message-Id: <1120321543.7270.39.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-02 at 14:54 +0200, David Gómez wrote:
> Hi Robert,
> 
> On Jul 01 at 04:25:15, Robert Love wrote:
> > > either introduced by inotify or just made more likely (i.e. 100% of time) 
> > > by inotify but the change is elsewhere.
> > 
> > The mount case is baffling.  Inotify has no interaction whatsoever with
> > mounting.  Unmounting, definitely--see fs/inotify.c ::
> > inotify_unmount_inodes().
> 
> Good news are that it seems unrelated to inotify. I updated to 2.6.13-rc1, and
> tested it with and without the inotify patch. Now I get the mount process
> hanged in inode_wait with the vanilla kernel, and working perfectly with the
> patched one. Weird...

Sorry to hear that your problem continues, but glad to hear that it is
not inotify.  I was baffled by a lockup in mount; it made no sense.

Good luck finding a fix!

	Robert Love


