Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275002AbTHFKOj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 06:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275003AbTHFKOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 06:14:39 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:52698 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S275002AbTHFKOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 06:14:35 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Wed, 6 Aug 2003 12:14:32 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: muizelaar@rogers.com, linux-kernel@vger.kernel.org,
       mru@users.sourceforge.net
Subject: Re: FS: hardlinks on directories
Message-Id: <20030806121432.19f77d27.skraw@ithnet.com>
In-Reply-To: <16176.22022.382294.55110@gargle.gargle.HOWL>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<yw1xsmohioah.fsf@users.sourceforge.net>
	<20030804152226.60204b61.skraw@ithnet.com>
	<3F2E7C63.2000203@rogers.com>
	<20030804181500.074aec51.skraw@ithnet.com>
	<16175.6729.962817.135747@gargle.gargle.HOWL>
	<20030805114125.30a12916.skraw@ithnet.com>
	<16176.22022.382294.55110@gargle.gargle.HOWL>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003 11:12:38 +1000
Neil Brown <neilb@cse.unsw.edu.au> wrote:

> On Tuesday August 5, skraw@ithnet.com wrote:
> > > > Hm, and I just found out that re-exporting "mount --bind" volumes does
> > > > not work over nfs...
> > > > 
> > > > Is this correct, Neil?
> > > 
> > > Yes, though there is a reasonable chance that it can be made to work
> > > with linux-2.6.0 and nfs-utils-1.1.0 (neither of which have been
> > > released yet:-)
> > 
> > Is this a complex issue? Can you imagine a not-too-big sized patch can make
> > it work in 2.4? What is the basic reason it does in fact not work?
> 
> On reflection, it could probably work in 2.4 and current nfs-utils,
> but admin might be a bit clumsy.
> 
> To allow knfsd to see a mountpoint, you have to export the mounted
> directory with the "nohide" option.  Currently "nohide" only works
> properly for exports to specific hosts, not to wildcarded hosts or
> netgroups.
> So if your /etc/export contains:
> 
>   /path/to/some/--bind/mountpoint servername(nohide,....)
> 
> for every mountpoint and every server, then it should work.

Hm, bad luck. I tried and it did not work. I used 2.4.20 kernel, are there
chances a later kernel might work?

Regards,
Stephan
