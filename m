Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752025AbWJAFjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbWJAFjh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 01:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbWJAFjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 01:39:37 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:53130 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1752025AbWJAFjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 01:39:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index:message-id;
        b=CS89LWekaf+ajVR0GhU5A6HzZBVMphp17m/N6tw33grSIdd+eRXFRLJxf6sR7OahF9ql2jQuz+FiCkQYR3lGgfYyb0AOa+YrgdbP6CyKff23kH8AOPgEjFr+9ThJaJv9z70KOa9u4m6u9ClOaAoPoGxTTBX3JC5vkPBmAOe1r6Q=
From: "Chris Lee" <labmonkey42@gmail.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "'Ju, Seokmann'" <Seokmann.Ju@lsil.com>,
       <linux-scsi@vger.kernel.org>, <Neela.Kolli@engenio.com>
Subject: RE: Problem with legacy megaraid
Date: Sun, 1 Oct 2006 00:39:37 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20060930155410.8238c195.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Thread-Index: Acbk41rgW8c722TNQkeBR0VTHdETVAANoGgg
Message-ID: <451f5496.40cc4d00.1456.ffffef37@mx.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your response Andrew.  Comment responses in-line:

> 
> > I am not subscribed to this list.  Please CC me on replies.
> 
> (more cc's added)
> 

Outstanding; thank you.

> > I have a machine I'm trying to use as a file server.  I 
> have a RAID10 and a
> > RAID5 on a single Dell PERC2/DC (AMI Megaraid 467) 
> controller.  Both arrays
> > are also on the same SCSI channel.  The system runs fine 
> for days on end
> > until I put some heavy I/O load on either array and sustain 
> it for a few
> > seconds.
> 
> We recently discovered that "The old megaraid driver is 
> apparently borken
> for firmware newer than 6.61.".  So please check that and see if a
> downgrade is needed.
> 

The Dell firmware version on the card currently is 1.06.  I have not found a
newer firmware version than that one.

> Is there some reason why you cannot use the new megaraid driver?
> 

The config help for the megaraid drivers suggested that the new megaraid
driver would not support a PERC2.  I had enabled both drivers in the kernel
which is having this problem.:

CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=y
CONFIG_MEGARAID_MAILBOX=y
CONFIG_MEGARAID_LEGACY=y

After your suggestion I rebuilt the kernel with legacy disabled.:

CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=y
CONFIG_MEGARAID_MAILBOX=y
# CONFIG_MEGARAID_LEGACY is not set

The new megaraid driver does not detect the PERC2/DC just as I feared it
would not.  Unless I'm missing some kernel commandline arguments necessary
to make the new driver find the card, I'm stuck with legacy.

> 
> > Distro: Gentoo Linux
> > Kernel: 2.6.17-gentoo-r7
> > 
> > Hardware:
> > Motherboard: Tyan Thunder i7501 Pro (S2721-533)
> > CPUs: Dual 2.8Ghz P4 HT Xeons
> > RAM: 4GB registered (3/1 split, flat model)
> > RAID: Dell PERC2/DC (AMI Megaraid 467)
> > SCSI: Adaptec AHA-2940U2/U2W PCI
> > NICs: onboard e100 and dual onboard e1000
> > 

<snip>

Thanks,
Chris  

