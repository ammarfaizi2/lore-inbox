Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268370AbTGIOMj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 10:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268369AbTGIOMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 10:12:38 -0400
Received: from mail.ithnet.com ([217.64.64.8]:58637 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S268346AbTGIOLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 10:11:33 -0400
Date: Wed, 9 Jul 2003 16:25:35 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Oleg Drokin <green@namesys.com>
Cc: mason@suse.com, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
Message-Id: <20030709162535.175d5fd3.skraw@ithnet.com>
In-Reply-To: <20030709141111.GK18307@namesys.com>
References: <20030706183453.74fbfaf2.skraw@ithnet.com>
	<1057515223.20904.1315.camel@tiny.suse.com>
	<20030709140138.141c3536.skraw@ithnet.com>
	<1057757764.26768.170.camel@tiny.suse.com>
	<20030709134837.GJ18307@namesys.com>
	<20030709141111.GK18307@namesys.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jul 2003 18:11:11 +0400
Oleg Drokin <green@namesys.com> wrote:

> Hello!
> 
> On Wed, Jul 09, 2003 at 03:58:03PM +0200, Stephan von Krawczynski wrote:
> > > > Step one is to figure out if the problem is reiserfs or 3ware.  Instead
> > > > of mounting the filesystem, run debugreiserfs -d /dev/xxxx > /dev/null
> > > > and see if you still hang.
> > > > This will read the FS metadata and should generate enough io to trigger
> > > > the hang if it is a 3ware problem.
> > Ok, I tried this. debugreiserfs runs without any problems. Disks show quite
> > an activity, the whole thing lasts 1-2 minutes.
> > mount afterwards shows the same hang.
> 
> Hm.
> 
> > > Or if this one suceeds, then may be reiserfsck --check /dev/xxxx to get
> > > journal replayed. This is in case access pattern matters.
> > I can try that, too. What do you expect to see?
> 
> Well, it will either hang or not, I think.
> It it won't hang, this will complicate matters.
> Then next step would be probably to try and mount the partition from
> usermodelinux if you are able to conduct such a test.
> I am still pretty skeptical about the possibility that recent reiserfs
> changes broke stuff.
> 
> Bye,
>     Oleg

ok, I did the reiserfsck and it works flawlessly. No errors no problems no
hang.
I tried mount afterwards and it still hangs.
Is there some recent change around the mount procedure itself? maybe it is
really unrelated to reiserfs and 3ware...

Regards,
Stephan

PS to Marcelo:
There is a problem with 2.4.22-pre3. I cannot mount a reiserfs data-partition
with 320 GB size located on a 3ware RAID. It just hangs the box, during init or
any runlevel I tried. It is completely reproducable, but debugreiserfs on the
partition and reiserfsck both show no problems at all ...
The things mounts flawlessly under 2.4.22-pre2 and below.


