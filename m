Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265145AbTGHR4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 13:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbTGHRz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 13:55:59 -0400
Received: from pat.uio.no ([129.240.130.16]:62411 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264792AbTGHRzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 13:55:53 -0400
To: Hanna Linder <hannal@us.ibm.com>
Cc: Matthew Wilcox <willy@debian.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] Fastwalk: reduce cacheline bouncing of d_count (Changelog@1.1024.1.11)
References: <16138.53118.777914.828030@charged.uio.no>
	<1057673804.4357.27.camel@dhcp22.swansea.linux.org.uk>
	<16138.56467.342593.715679@charged.uio.no>
	<1057677613.4358.33.camel@dhcp22.swansea.linux.org.uk>
	<20030708164426.GB10004@www.13thfloor.at>
	<1057683213.5228.3.camel@dhcp22.swansea.linux.org.uk>
	<20030708170628.GA13593@www.13thfloor.at>
	<20030708172028.GB1939@parcelfarce.linux.theplanet.co.uk>
	<27230000.1057686164@w-hlinder>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 08 Jul 2003 20:10:10 +0200
In-Reply-To: <27230000.1057686164@w-hlinder>
Message-ID: <shsvfucanzx.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Hanna Linder <hannal@us.ibm.com> writes:

     > The change Trond pointed out was added by Al Viro
     > after fastwalk was included in 2.5.11 which I backported.

IIRC, Al vetoed the NFS cto change that went into 2.4.x because he
claimed he was planning on providing an alternative fix that would
better fit the unionfs.
As that apparently won't materialize in 2.6.x, I'm in any case
planning on presenting the open(".") patch (or some variant of it) to
Linus.

That said, just backing a bugfix out of a stable kernel without
providing an alternative solution should only be done in those cases
where keeping it would cause a worse problem. For instance if the fix
is a security issue...

Cheers,
  Trond
