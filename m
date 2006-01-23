Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWAWVqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWAWVqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 16:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWAWVqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 16:46:30 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:16055 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S964894AbWAWVq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 16:46:29 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 23 Jan 2006 22:45:37 +0100
To: rlrevell@joe-job.com, matthias.andree@gmx.de
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was: 
 Rationale for RLIMIT_MEMLOCK?)
Message-ID: <43D54E81.nailC6M5ZIPCH@burner>
References: <20060123105634.GA17439@merlin.emma.line.org>
 <1138014312.2977.37.camel@laptopd505.fenrus.org>
 <20060123165415.GA32178@merlin.emma.line.org>
 <1138035602.2977.54.camel@laptopd505.fenrus.org>
 <20060123180106.GA4879@merlin.emma.line.org>
 <1138039993.2977.62.camel@laptopd505.fenrus.org>
 <20060123185549.GA15985@merlin.emma.line.org>
 <43D530CC.nailC4Y11KE7A@burner> <1138048255.21481.15.camel@mindpipe>
 <20060123212119.GI1820@merlin.emma.line.org>
 <1138051613.21481.37.camel@mindpipe>
In-Reply-To: <1138051613.21481.37.camel@mindpipe>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:

> On Mon, 2006-01-23 at 22:21 +0100, Matthias Andree wrote:
> > Sounds really good. Can you give a pointer as to the detailed rlimit
> > requirements? 
>
> I don't want to touch the rest of the thread, but the best info on the
> above can be found in the linux-audio-user list archives.  It's still a
> little unclear exactly which packages are required, but IIRC PAM 0.80
> supports it already.  I believe this requires glibc changes eventually,
> but programs like PAM and bash that deal with rlimits can work around it
> if glibc is not aware of the new rlimit.

Could you explain this more in depth?

What you describe looks like you propose to add a line:

joerg::::defaultpriv=file_dac_read,sys_devices,proc_lock_memory,proc_priocntl,net_privaddr

to /etc/user_attr which would be honored by PAM during login.

This is not what I like to see.

What I like to see is that only specific programs like cdrecord
would get the permissions to do more than joe user.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
