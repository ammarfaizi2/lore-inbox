Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVCIXbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVCIXbl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVCIXaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:30:19 -0500
Received: from mirapoint2.TIS.CWRU.Edu ([129.22.104.47]:56150 "EHLO
	mirapoint2.tis.cwru.edu") by vger.kernel.org with ESMTP
	id S262016AbVCIX2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:28:37 -0500
From: prj@po.cwru.edu (Paul Jarc)
To: linux-kernel@vger.kernel.org
Cc: users@spamassassin.apache.org, misc@list.smarden.org,
       supervision@list.skarnet.org, mkettler@evi-inc.com, nix@esperi.org.uk
Subject: Re: a problem with linux 2.6.11 and sa
In-Reply-To: <20050309152958.GB4042@ixeon.local> (George Georgalis's message
	of "Wed, 9 Mar 2005 10:29:59 -0500")
Organization: What did you have in mind?  A short, blunt, human pyramid?
References: <20050303214023.GD1251@ixeon.local>
	<6.2.1.2.0.20050303165334.038f32a0@192.168.50.2>
	<20050303224616.GA1428@ixeon.local>
	<871xaqb6o0.fsf@amaterasu.srvr.nix>
	<20050308165814.GA1936@ixeon.local>
	<871xap9dfg.fsf@amaterasu.srvr.nix>
	<20050309152958.GB4042@ixeon.local>
Mail-Copies-To: nobody
Mail-Followup-To: linux-kernel@vger.kernel.org, users@spamassassin.apache.org,
	misc@list.smarden.org, supervision@list.skarnet.org,
	mkettler@evi-inc.com, nix@esperi.org.uk
Date: Wed, 09 Mar 2005 18:28:35 -0500
Message-ID: <m3is40z9dy.fsf@multivac.cwru.edu>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"George Georgalis" <george@galis.org> wrote:
> It (Gerrit Pape's technique) very defiantly stopped working a few revs
> back (2.6.7?). I'm seeing a similar failed read from /dev/rtc and
> mplayer with 2.6.10, now too.

The /proc/kmsg problem happens because the kernel now checks for
permission at read() instead of open().  The /dev/rtc problem seems to
be a different beast.

> while read file; do mplayer $file ; done <mediafiles.txt
>
> Failed to open /dev/rtc: Permission denied
>
> for file in `cat mediafiles.txt`; do mplayer $file ; done
>
> works.

To simplify, what about these two:
mplayer foo.mpg
mplayer foo.mpg < mediafiles.txt

You might try strace'ing both cases and see how they compare.


paul
