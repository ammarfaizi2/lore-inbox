Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268330AbUIPXV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268330AbUIPXV7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268337AbUIPXVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:21:01 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:65212 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S268348AbUIPXSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:18:25 -0400
Subject: Re: [PATCH] Suspend2 Merge: Driver model patches 2/2
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@digeo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040916230713.GA16403@kroah.com>
References: <1095332331.3855.161.camel@laptop.cunninghams>
	 <20040916142847.GA32352@kroah.com>
	 <1095373127.5897.23.camel@laptop.cunninghams>
	 <20040916223539.GA16151@kroah.com>
	 <1095374947.6537.34.camel@laptop.cunninghams>
	 <20040916230713.GA16403@kroah.com>
Content-Type: text/plain
Message-Id: <1095376793.5902.49.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 17 Sep 2004 09:19:53 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-09-17 at 09:07, Greg KH wrote:
> > What's broken? (I want to learn what I've done wrong that I'm not
> > seeing).
> 
>  - No locking when traversing the list.
>  - Reference count needs to be bumped before returning a pointer to the
>    object you found.

Ah. Fair enough. I haven't seen any problems because the locking is more
abstract: processes are frozen when this runs for suspend. I'll fix it,
but won't bother resubmitting it because Pavel's changes should obsolete
this stuff.

> > > mention the fact that the functionality this function proposes to offer
> > > is not needed either.
> > > 
> > > > (their patch just fills in a field that was left blank previously),
> > > 
> > > What patch?
> > 
> > Attached. Sorry if I wrongly assumed this was the patch you're talking
> > about.
> 
> Ah, no, I've never seen this one, thanks.  But it looks sane, I don't
> have a problem with it (sysfs will like it, it's not a suspend specific
> patch at all.)

Antonio posted it to LKML last week IIRC, which is why I didn't include
it in the device driver patches. Given Pavel's changes (again), I'm in
two minds as to whether its needed. It's clearly the right thing to do,
but not needed at the moment. Then again, as we noted already, the whole
device_class thing doesn't get a lot of use at the moment.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

