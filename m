Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWFSSTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWFSSTg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWFSSTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:19:36 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:25487 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751278AbWFSSTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:19:35 -0400
Date: Mon, 19 Jun 2006 14:19:15 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Preben Traerup <Preben.Trarup@ericsson.com>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] kdump: add a missing notifier before crashing
Message-ID: <20060619181915.GD8172@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060615201621.6e67d149.akiyama.nobuyuk@jp.fujitsu.com> <m1d5d9pqbr.fsf@ebiederm.dsl.xmission.com> <20060616211555.1e5c4af0.akiyama.nobuyuk@jp.fujitsu.com> <m1odwtnjke.fsf@ebiederm.dsl.xmission.com> <20060619163053.f0f10a5e.akiyama.nobuyuk@jp.fujitsu.com> <m1y7vtia7r.fsf@ebiederm.dsl.xmission.com> <4496A677.3020301@ericsson.com> <m1hd2hhyzn.fsf@ebiederm.dsl.xmission.com> <20060619170711.GB8172@in.ibm.com> <m1zmg9ghlr.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1zmg9ghlr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 11:50:24AM -0600, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@in.ibm.com> writes:
> 
> > On Mon, Jun 19, 2006 at 10:49:32AM -0600, Eric W. Biederman wrote:
> >
> > Sounds like trouble for modules. I am assuming that code to power down the
> > scsi disks/controller will be part of the driver, which is generally built
> > as a module and also assuming that powering down the disks is a valid
> > requirement after the crash.
> 
> I'm assuming if anything is important and critical enough to be in a crash
> notifier it can be built into the kernel.
> 
> > After introducing an option to disable/enable crash notifiers from user
> > space I think now responsibility lies to with user. If he chooses to enable
> > the notifiers, he understands that there are chances that we never boot
> > into the next kernel and get lost in between. 
> 
> At the moment this is a lot of infrastructure for a vaguely defined
> case that I have yet to see defined.
> 
> One of the reasons using kexec for this kind of activity was precisely
> because it doesn't do any of this when the kernel is known to be
> broken.
> 
> Having notifiers and being able to disable them is designing for an
> unspecified case.  We need to concentrate on the fundamentals here.
> Do any of these crash notifiers make sense?
> 

Agreed. That makes sense. Probably folks who want this functionality
should also post the code which they would like to run from inside the
notifiers so that requirement is understood more clearly.

Thanks
Vivek
