Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263324AbUEBWK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbUEBWK1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 18:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUEBWK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 18:10:26 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:24837 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263324AbUEBWKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 18:10:20 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] Filesystem with multiple mount-points
Date: Mon, 3 May 2004 01:10:00 +0300
User-Agent: KMail/1.5.4
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, GNU/Dizzy <dizzy@roedu.net>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0405021951100.2613-100000@poirot.grange>
In-Reply-To: <Pine.LNX.4.44.0405021951100.2613-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405030110.00102.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 May 2004 20:58, Guennadi Liakhovetski wrote:
> On Sun, 2 May 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > <shrug>
> >
> > mount <whatever> /tmp/blah
> > mount --bind /tmp/blah/relative_path /desired_mountpoint
> > umount -l /tmp/blah
>
> Wow! I, actually, thought about it, but I didn't expect it to work right
> now, I would expect the umount to fail with EBUSY... But it does work!
> Guys, it rocks! The only slight inconvenience - mount still shows
>
> /tmp/blah/relative_path /desired_mountpoint (bind)
>
> which is not necessarily informative. A better display would be, perhaps
>
> <whatever>:relative_path /desired_mountpoint (bind)
>
> in /proc/mounts also not quite true:
>
> <whatever> /desired_mountpoint

You haven't symlinked /etc/mtab to /proc/mounts.
I always do it. Kernel knows better what is mounted, and where.
(at least supposed to know. You are right, currently /proc/mtab
is a bit not ok regarding bind mounts).

/etc/mtab is a historic userspace
hack for ancient Unix systems where kernel had no way to export
that info.
--
vda

