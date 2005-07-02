Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVGBM5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVGBM5f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 08:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVGBM5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 08:57:35 -0400
Received: from 90.Red-213-97-199.pooles.rima-tde.net ([213.97.199.90]:32131
	"HELO fargo") by vger.kernel.org with SMTP id S261192AbVGBM5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 08:57:31 -0400
Date: Sat, 2 Jul 2005 14:54:04 +0200
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: Robert Love <rml@novell.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
       John McCutchan <ttb@tentacle.dhs.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with inotify
Message-ID: <20050702125403.GA904@fargo>
Mail-Followup-To: Robert Love <rml@novell.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	John McCutchan <ttb@tentacle.dhs.org>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050630181824.GA1058@fargo> <1120156188.6745.103.camel@betsy> <20050630193320.GA1136@fargo> <Pine.LNX.4.60.0506302138230.29755@hermes-1.csi.cam.ac.uk> <20050630204832.GA3854@fargo> <Pine.LNX.4.60.0506302158190.29755@hermes-1.csi.cam.ac.uk> <1120249515.6745.177.camel@betsy>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1120249515.6745.177.camel@betsy>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Jul 01 at 04:25:15, Robert Love wrote:
> > either introduced by inotify or just made more likely (i.e. 100% of time) 
> > by inotify but the change is elsewhere.
> 
> The mount case is baffling.  Inotify has no interaction whatsoever with
> mounting.  Unmounting, definitely--see fs/inotify.c ::
> inotify_unmount_inodes().

Good news are that it seems unrelated to inotify. I updated to 2.6.13-rc1, and
tested it with and without the inotify patch. Now I get the mount process
hanged in inode_wait with the vanilla kernel, and working perfectly with the
patched one. Weird...

> [ Attached is the latest inotify, against 2.6.13-rc1. ]

I tested it with this patch.

bye

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
