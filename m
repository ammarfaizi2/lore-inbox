Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWBVQvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWBVQvp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWBVQvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:51:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33930 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030223AbWBVQvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:51:43 -0500
Date: Wed, 22 Feb 2006 16:51:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Zeuthen <david@fubar.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Kay Sievers <kay.sievers@suse.de>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, Greg KH <gregkh@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Robert Love <rml@novell.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222165139.GA19223@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Zeuthen <david@fubar.dk>, Linus Torvalds <torvalds@osdl.org>,
	Kay Sievers <kay.sievers@suse.de>,
	Pekka J Enberg <penberg@cs.Helsinki.FI>, Greg KH <gregkh@suse.de>,
	Adrian Bunk <bunk@stusta.de>, Robert Love <rml@novell.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	John Stultz <johnstul@us.ibm.com>
References: <1140383653.11403.8.camel@localhost> <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost> <20060221225718.GA12480@vrfy.org> <Pine.LNX.4.58.0602220905330.12374@sbz-30.cs.Helsinki.FI> <20060222152743.GA22281@vrfy.org> <Pine.LNX.4.64.0602220737170.30245@g5.osdl.org> <1140625103.21517.18.camel@daxter.boston.redhat.com> <20060222163511.GA18694@infradead.org> <1140626762.21517.24.camel@daxter.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140626762.21517.24.camel@daxter.boston.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 11:46:01AM -0500, David Zeuthen wrote:
> > you'd see in the relevant
> > standards what scsi device types exist, or even better stop relying
> > on such low-level knowledge.  
> 
> Then don't export it unless it's useful. You did break ABI, don't try to
> make up stupid excuses.

It's _not_ and abi break.  TYPE_RBC is a valid scsi disk device that could
happen on any SAM transport, not just firewire.  That sbp2 altered the
device type just papered over the crappy hal code as long as none of your
users had one of the non-firewire rbc devices.

