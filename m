Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVC3UqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVC3UqE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 15:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVC3UoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 15:44:01 -0500
Received: from 76.80-203-227.nextgentel.com ([80.203.227.76]:25591 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S261688AbVC3UnX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 15:43:23 -0500
To: Wiktor <victorjan@poczta.onet.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] 'nice' attribute for executable files
References: <fa.ed33rit.1e148rh@ifi.uio.no>
	<E1DGNaV-0005LG-9m@be1.7eggert.dyndns.org>
	<424ACEA9.6070401@poczta.onet.pl>
	<yw1xpsxhvzsz.fsf@ford.inprovide.com>
	<424AE18B.1080009@poczta.onet.pl>
	<yw1xll85vtva.fsf@ford.inprovide.com>
	<424B090F.3090508@poczta.onet.pl>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Wed, 30 Mar 2005 22:43:22 +0200
In-Reply-To: <424B090F.3090508@poczta.onet.pl> (Wiktor's message of "Wed, 30
 Mar 2005 22:16:15 +0200")
Message-ID: <yw1xhdisx3th.fsf@ford.inprovide.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wiktor <victorjan@poczta.onet.pl> writes:

> Måns Rullgård wrote:
>>
>> You could wrap /lib/ld-linux.so, and get all dynamically linked
>> programs done in one sweep.
>>
> That's mad idea -

Sure, but it's possible.

> keep similar things in one place! starting programs is done in
> kernel and nice-value-support is also done in kernel!!

Just because it can be done in the kernel, doesn't mean it should be.
In fact, the more that can be kept outside the kernel, the better.

>> Using a shell to run external programs is quite common.  The system()
>> and popen() functions both invoke the shell.
>>
> Yes, but compexity of 'sh -c /some/command' is uncomparable to one of
> shell-level-program-renicing system. such system should keep database
> of reniced processes, parse it (using awk or sed, i'm afraid...) and

It wouldn't need to be more complicated than a POSIX extended
attribute.

> then renice process (what also takes two files[!, they are in fact
> one-liners, but it is needed to gain root privileges to renice
> process]). sorry, but linux works smoothly on 386, and such mess would
> surely change it.

The Linux kernel is pretty stable, but tampering with internals in
such a way would surely change it.

>> I'm not so sure it belongs at all.  The can of worms it opens up is a
>> bit too big, IMHO.
>>
> What can?

Pandora's.

> the only account that have access to renicing field is root. if

So you are proposing the addition of a per-file attribute, with
restricted access, and potentially dangerous effects if set
incorrectly.  This, combined with the fact that is unlikely to receive
much testing, all speaks against it.

-- 
Måns Rullgård
mru@inprovide.com
