Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264768AbUD1N1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264768AbUD1N1I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 09:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264774AbUD1N1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 09:27:08 -0400
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:55306 "EHLO
	ford.pronto.tv") by vger.kernel.org with ESMTP id S264768AbUD1N1F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 09:27:05 -0400
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What does tainting actually mean?
References: <opr65eq9ncshwjtr@laptop-linux.wpcb.org.au>
	<20040428042742.GA1177@middle.of.nowhere>
	<opr65f48sfshwjtr@laptop-linux.wpcb.org.au>
	<408F3EE4.1080603@nortelnetworks.com>
	<opr65ic90vshwjtr@laptop-linux.wpcb.org.au>
	<20040428121009.GA2844@thunk.org> <yw1x7jw0mfoh.fsf@kth.se>
	<20040428130402.GB9820@mulix.org>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Date: Wed, 28 Apr 2004 15:27:00 +0200
In-Reply-To: <20040428130402.GB9820@mulix.org> (Muli Ben-Yehuda's message of
 "Wed, 28 Apr 2004 16:04:02 +0300")
Message-ID: <yw1x3c6omdwb.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <mulix@mulix.org> writes:

> On Wed, Apr 28, 2004 at 02:48:30PM +0200, Måns Rullgård wrote:
>> > Stack overflows in a badly written device driver can overwrite task
>> > structures and cause apparent filesystem problems which are blamed on
>> > the hapless filesystem authors instead of where the blame properly
>> > lies, namely the device driver author.
>> 
>> Wouldn't the problem be just as difficult to pin to a certain module
>> even if the source code was open?  I prefer open source modules (I
>> have Alpha machines), but I just can't see this argument work.
>
> No. If the code is open, you can read it and find the bug - just by
> reading it. If the code is closed, your only recourse is to observe
> the corruption while it happens or read the assembly, which is quite a
> lot more difficult. 

Something has to hint to as to which code to read.  The usual way to
find the offending module is to remove modules until the problem goes
away.  The availability of source code only matters when you have
found which module actually has the bug.  If you have the source you
can fix it, otherwise you can't.  If a bug in an open source module
causes random filesystem corruption people will be just as likely to
blame the filesystem code for it as if the buggy module is closed
source.  This is pretty obvious, because if you don't know where the
bug actually is, the openness of that source code can't possibly make
a difference.

-- 
Måns Rullgård
mru@kth.se
