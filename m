Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWBTBLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWBTBLi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 20:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbWBTBLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 20:11:38 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:14217 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932494AbWBTBLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 20:11:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=O5cDZwyBFSJ6A/Wp2ZOqq6mBOCuNV26YUIUuZF85yClxzxja9oXK3aw26v7cQm6KDW1vcibqVikp14zjd3P2uQ1bpADAXAYOh4AociRAESQI6kjDxvkuZHBkSZ3os7Mkpgx5nKOH8zUfcGHLUi11kvbzDRUOF9x4t+Nh24LtiRg=
Date: Mon, 20 Feb 2006 05:11:30 +0200
From: Sasha Khapyorsky <sashakh@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: s.schmidt@avm.de, Greg KH <greg@kroah.com>, torvalds@osdl.org,
       kkeil@suse.de, LKML <linux-kernel@vger.kernel.org>,
       opensuse-factory@opensuse.org, libusb-devel@lists.sourceforge.net,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.16 serious consequences / GPL_EXPORT_SYMBOL / USB drivers of major vendor excluded
Message-ID: <20060220031130.GA9929@khap>
References: <20060205205313.GA9188@kroah.com> <OFED05BE20.31E2BACE-ONC1257115.005DE6CA-C1257117.004F2C48@avm.de> <20060219045716.GA9880@khap> <Pine.LNX.4.58.0602191158410.12662@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0602191158410.12662@gandalf.stny.rr.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:02 Sun 19 Feb     , Steven Rostedt wrote:
> 
> > > differences between AVM and other devices and the difficulties regarding a
> > > possible move towards user mode.
> > >
> > > The user space does not ensure the reliability of time critical analog
> > > services like Fax G3 or analog modem emulations. This quality of service
> > > can only be guaranteed within the kernel space.
> >
> > Soft modems may work pretty well in userspace - slmodem is example.
> >
> > Real-time requirement for V.34 is 40ms response time and only once during
> > the session when echo canceller parameters are negotiatiated (so you may
> > decrease "buffer size" before and increase after - there are enouph
> > silence places for such manipulations). Fax itself does not require any
> > "realtime" AFAIK, other place is almost unused today V.32 - 26ms, also
> > for echo canceller setup.
> >
> 
> Disclaimer:  This is in no way a push to get the -rt patch into mainline
> at the moment.  The patch is still young and is not ready yet.

Hmm, it was not about -rt patch - 40 millisecond response time is
realistic for userspace even without -rt patch. There is no guarantee,
but in practice this may work very well and keep low percents of failures
(much lower than permitted by standards).

Sasha.
