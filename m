Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275060AbTHQHNj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 03:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275063AbTHQHNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 03:13:38 -0400
Received: from codepoet.org ([166.70.99.138]:12176 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S275060AbTHQHNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 03:13:37 -0400
Date: Sun, 17 Aug 2003 01:13:32 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 5/8 Backport recent 2.6 IDE updates to 2.4.x
Message-ID: <20030817071332.GA18234@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Willy Tarreau <willy@w.ods.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andries Brouwer <aebr@win.tue.nl>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030817061338.GF17621@codepoet.org> <20030817065954.GF29616@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030817065954.GF29616@alpha.home.local>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Aug 17, 2003 at 08:59:54AM +0200, Willy Tarreau wrote:
> On Sun, Aug 17, 2003 at 12:13:39AM -0600, Erik Andersen wrote:
> 
> > +	printk(KERN_INFO "%s: Host Protected Area detected.\n"
> > +			 "\tcurrent capacity is %ld sectors (%ld MB)\n"
> > +			 "\tnative  capacity is %ld sectors (%ld MB)\n",
> > +			 drive->name,
> > +			 capacity, (capacity - capacity/625 + 974)/1950,
> > +			 set_max, (set_max - set_max/625 + 974)/1950);
> 
> Just a question : why didn't you use your sectors_to_MB() function here, to
> make this replace the unreadable hack above ?

Mainly because sectors_to_MB() didn't exist yet when I wrote this
part.  :-)  This was later fixed by Andries Brouwer. which shows up 
in patch #7,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
