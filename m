Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVCUIYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVCUIYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 03:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVCUIYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 03:24:11 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:45406 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261684AbVCUIXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 03:23:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=cAczyts2c6T5zO52XvbcXAVWNBVY80rYJDSUy/tVyt5/ThlIh5/jBZTFZvcjxMuAS7f/EjhskxHnziIkXWsTjOUHrVTkiRcNgfp2RpUo8yIYDtZi4mfpkjSUaEkSnM0sFNbLXLKAIr0ux7mIPYAHfan/lYcTFyapvHoSAOIT1j0=
Message-ID: <58cb370e050321002313213dbd@mail.gmail.com>
Date: Mon, 21 Mar 2005 09:23:14 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Paul <set@pobox.com>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Repeatable IDE Oops for 2.6.11 (ide-scsi vs ide-cdrom)
In-Reply-To: <20050318182754.GC7974@squish.home.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050314065508.GA7974@squish.home.loc>
	 <58cb370e05031808341bbe5622@mail.gmail.com>
	 <20050318182754.GC7974@squish.home.loc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2005 13:27:54 -0500, Paul <set@pobox.com> wrote:
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, on Fri Mar 18, 2005 [05:34:06 PM] said:
> > On Mon, 14 Mar 2005 01:55:08 -0500, Paul <set@pobox.com> wrote:
> > >         Hi;
> > >
> > >         Here is what I did:
> > >
> > > # modprobe ide-scsi
> > > # cd /proc/ide/hdd      (this is a dvdrw drive)
> > > # cat driver
> > > > ide-cdrom version 4.61
> > > # echo ide-scsi > driver
> > > # cat driver
> > > > ide-scsi (something--- didnt note exactly, except it was ide-scsi)
> > > # echo ide-cdrom > driver
> > >
> > > The shell is killed and Oops.
> > >
> > > Machine flakey and half alive at this point. Reboot with Alt-sysrq.
> > > The same thing works with 2.6.10, without Oops.
> >
> > Please see http://lkml.org/lkml/2005/2/11/132
> 
>         Hi;
> 
>         What is the nature of the 'ide-dev-2.6 tree'? Are there broken
> out patches available I can test vs. 2.6.11 or -mm? How do the 'ide fixes'

it is BK tree which is pulled into -mm, no patches against vanilla kernels (yet)

> in -ac intersect with ide-dev? I am also curious if these patches could

locking 'ide fixes' in -ac are another approach to the same problem

> have any effect on the pktcdvd problems I have reported.[*]

This issue looks like pktcdvdv/udf specific thing so these patches won't help.

>         Thanks for the feedback.
> 
> Paul
> set@pobox.com
> 
> * http://lists.suse.com/archive/packet-writing/2005-Mar/0001.html
>
