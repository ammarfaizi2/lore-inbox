Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263909AbTLUTJV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 14:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263914AbTLUTJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 14:09:21 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:22978 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S263909AbTLUTJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 14:09:20 -0500
To: Ben Collins <bcollins@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Firewire/sbp2 troubles with Linux 2.6.0
References: <yw1x8yl66ecs.fsf@ford.guide>
	<20031221035348.GM6607@phunnypharm.org> <yw1x4qvumozm.fsf@ford.guide>
	<20031221144813.GN6607@phunnypharm.org> <yw1xn09mkvs9.fsf@ford.guide>
	<20031221183132.GP6607@phunnypharm.org>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Sun, 21 Dec 2003 20:09:15 +0100
In-Reply-To: <20031221183132.GP6607@phunnypharm.org> (Ben Collins's message
 of: 31:32 -0500")
Message-ID: <yw1x4qvu6l9g.fsf@ford.guide>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins <bcollins@debian.org> writes:

>> > I've seen that before with an old card that I had. I was forced to
>> > either serialize the serial commands in sbp2, or reduce the max speed to
>> > S200.
>> 
>> Setting serialize_io=1 seems to help.  I managed to read an 800 MB
>> file at 10 MB/s.  What's the penalty for setting that?  And isn't 10
>> MB/s a little slow for Firewire?
>
> Basically that causes the scsi layer to only send sbp2 1 command at a
> time, so it's a performance hit.

I figured it would be.

> I'm guessing that your card doesn't like getting some many commands at
> once. It's possible that your sbp2 device itself cannot handle it
> (generally, I've found it to be caused by the card though).

Is it possible to set the limit somewhere between the default and
complete serialization?  Shouldn't it be possible to detect such
things automatically, somehow?

> As far as 10mbs, you have to remember that even though firewire is much
> higher than that, your drive is still an IDE, and the firewire is still
> going through an IDE bridge. So the limitation lies in the IDE bridge.
> I've seen performance as high as 34MB/s with good IDE bridges and
> drives, though.

The disks will easily do 40 MB/s on a good IDE controller.  It seems
like a rather bad bridge to me if it has that much overhead.  I
haven't seen many different options for sale, either.

-- 
Måns Rullgård
mru@kth.se
