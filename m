Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266147AbUHRN1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266147AbUHRN1i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 09:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUHRN1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 09:27:38 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:63072 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266147AbUHRN1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 09:27:36 -0400
Message-ID: <2a4f155d04081806272275a2c0@mail.gmail.com>
Date: Wed, 18 Aug 2004 16:27:35 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Reply-To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Paul Fulghum <paulkf@microgate.com>
Subject: Re: 2.6.8.1-mm1 Tty problems?
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <41235417.9080602@microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <2a4f155d040817070854931025@mail.gmail.com>	 <412271EF.6040201@microgate.com> <1092831738.26566.68.camel@moss-spartans.epoch.ncsc.mil> <41235417.9080602@microgate.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004 08:05:27 -0500, Paul Fulghum <paulkf@microgate.com> wrote:
> Stephen Smalley wrote:
> > I find that puzzling, given that flush_unauthorized_files is only called
> > if the process is changing SIDs on exec, and running less certainly
> > doesn't involve a SID transition (at least for any policy that I have
> > seen).  I tried the sequence shown with 2.6.8.1-mm1 with SELinux enabled
> > and disabled, and did not see the behavior he describes.  Is the bug
> > reproducible?  Was he running with SELinux enabled or disabled?  What
> > policy did he have loaded?
> 
> According to Ismail:
> * The problem is reproducible.
> * SELinux is disabled.
> * With the patch the problem occurs.
> * With the patch reversed, the problem went away.
> 
> Unfortunately, this appears to be mixed up with
> another 2.6.8.1-mm1 change causing udev to garble
> the creation of /dev/tty and pty devices.
> 
> Applying/reversing the controlling-tty patch in isolation
> creates/corrects the symptom with the less program,
> so there seems to be some relation.
> 
> --
> Paul Fulghum
> paulkf@microgate.com
> 


The problem ended up as a problem in Slackware's default udev.rules
file. Now I'm running vanilla -mm1 and everything works. Thank you all
for your attention!

Cheers,
ismail


-- 
Time is what you make of it
