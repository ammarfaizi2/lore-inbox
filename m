Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266143AbUHHSzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUHHSzB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 14:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUHHSzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 14:55:01 -0400
Received: from ppp-62-245-160-174.mnet-online.de ([62.245.160.174]:24758 "EHLO
	killer.ninja.frodoid.org") by vger.kernel.org with ESMTP
	id S266143AbUHHSyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 14:54:46 -0400
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408061018.i76AIdmV005276@burner.fokus.fraunhofer.de>
	<20040806175937.GA296@ucw.cz> <cf11qi$hjm$1@terminus.zytor.com>
	<20040808131507.147d57f6.skraw@ithnet.com>
From: Julien Oster <lkml-7994@mc.frodoid.org>
Organization: FRODOID.ORG
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	linux-kernel@vger.kernel.org
Date: Sun, 08 Aug 2004 20:58:26 +0200
In-Reply-To: <20040808131507.147d57f6.skraw@ithnet.com> (Stephan von
 Krawczynski's message of "Sun, 8 Aug 2004 13:15:07 +0200")
Message-ID: <87pt61jw31.fsf@killer.ninja.frodoid.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski <skraw@ithnet.com> writes:

>> > > If you do not fix this, you just verify that Linux does not like it's
>> > > users. Linux users like to call cdrecord -scanbus and they like to see
>> > > _all_ SCSI devices from a single call to cdrecord.
[...]

> To add a pure users' comment to the story:

Considering cdrecord, I am also a pure user. And my reaction when I
first used it and discovered the -scanbus/dev=id,id,id thingy was not
very pleasent. I was very confused by the fact that I couldn't just
give it /dev/whatever like I was used to with, well, everything
else. (I'm not only used to it, /dev/... is also how Linux works, from
my pov. That's just why it exists.)

I thought a minute about it and came to the immediate conclusion:
there's something wrong with the kernel interface, which prevents
cdrecord from just using the device file. I figured that someone would
fix it very soon and accepted the dev=id,id,id solution temporarily
(without really ever getting used to it).

Now I learned that it is a deliberate design issue with cdrecord and I
am left stunned.

Even before knowing that (i.e., some days ago) I still hated to
specify dev=id,id,id.

> Maybe you should not overestimate cdrecord as a tool (like its author obviously
> does sometimes). At least for DVD there are well-working alternatives.

Oh yes. I suspect you're talking of growisofs? I'm not kidding when I
tell you that I was really thrilled when I discovered that it allows
me to specify the device file. Remember, at that point I still thought
the dev=... was a bug and I was glad that the growisofs author found a
way to fix or workaround this bug (that's what I thought).

Since growisofs was doing a nice, straightforward job for me, I tried
to burn CD-Rs instead of DVDs with it, but unfortunately this didn't
work.

> If Joerg feels a better home on Solaris, so be it. It's his right to decide for
> solaris, just as it is a users' right to decide against cdrecord.

Well, do you know any alternatives for CD-Rs? I'm normally all the
"f* it, I'm just writing the tool myself and then I know it's doing
what I want"-guy, but I really don't feel the urge to get into
that ATAPI/burning stuff pressed on me.

Regards,
Julien
