Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266075AbUGENNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266075AbUGENNG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 09:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266072AbUGENNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 09:13:05 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:65286 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S266075AbUGENMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 09:12:22 -0400
Date: Mon, 5 Jul 2004 15:12:16 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>, bug-parted@gnu.org,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Clausen <clausen@gnu.org>,
       buytenh@gnu.org, msw@redhat.com
Subject: Re: Restoring HDIO_GETGEO semantics for 2.6 (was: Re: [RFC] Restoring HDIO_GETGEO semantics)
Message-ID: <20040705131216.GA24899@wsdw14.win.tue.nl>
References: <20040703005555.GA20808@apps.cwi.nl> <Pine.LNX.4.21.0407041920480.11076-100000@mlf.linux.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0407041920480.11076-100000@mlf.linux.rulez.org>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: mailhost.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2004 at 02:14:50PM +0200, Szakacsits Szabolcs wrote:

> There are three different problems.
> 
>  1) 2.6 kernels made very visible that the widely used Parted, libparted,
>     etc are severely broken. They should be FIXED. Off-topic on linux-kernel.

Indeed. Andrew's recent patch greatly improved the situation.
Recently we exchanged half a dozen letters. I have good hopes
that in the near future *parted will improve a bit more.

>  2) The semantic change of HDIO_GETGEO severely broke widely used, critical 
>     tools. This issue should be HANDLED, preferable as soon as possible. 
>     The original thread was supposed to be only about this issue.

Well. In case you reveal precisely which tools you are thinking of,
I am quite willing to contribute what I can to improve them.

>  3) There are cases when tools need to invent, not-to-be-discussed-now,
>     geometry for different kind of purposes. This should be IMPLEMENTED.

Again. You shout with capital letters, but it is more productive to do.
In case you reveal the purposes not-to-be-discussed-now of these anonymous
tools, then again, I am quite willing to contribute what I can.
My email address is aeb@cwi.nl. Maybe parted is being worked on.
We can discuss everything else that you think needs fixing.

> Considering all the above points, it seems logical from practical point 
> of view, that the restoration of the old HDIO_GETGEO functionality (or
> something that's very close to its behaviour) _temporarily_ for 2.6
> kernels makes sense.
> 
> Of course this wouldn't mean to be as a fix for the above 1) and 3)
> problems. It's the restoration of the user space compatibility _and_
> preparation for appropriate HDIO_GETGEO removal.

You have not convinced me. The change is over two years old.
Let us first discuss all these tools that may need fixing.

Andries


[Note that as it turns out there are situations involving a RAID
where one needs to know where the last cylinder starts. Funny.
This forces the kernel to have ideas about geometry at least for
that case.]

[Note that we saw last week that nowadays one meets FAT filesystems
with zero geometry fields that are reported to work fine with
Windows XP. Also Microsoft is trying to get away from this
geometry nonsense.]
