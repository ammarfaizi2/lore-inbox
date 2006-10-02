Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965235AbWJBSUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965235AbWJBSUP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965239AbWJBSUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:20:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47848 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965235AbWJBSUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:20:13 -0400
Date: Mon, 2 Oct 2006 11:15:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dan Williams <dcbw@redhat.com>, Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       "John W. Linville" <linville@tuxdriver.com>
Cc: Norbert Preining <preining@logic.at>,
       Alessandro Suardi <alessandro.suardi@gmail.com>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, ipw3945-devel@lists.sourceforge.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-Id: <20061002111537.baa077d2.akpm@osdl.org>
In-Reply-To: <1159808304.2834.89.camel@localhost.localdomain>
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at>
	<5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com>
	<20061002113259.GA8295@gamma.logic.tuwien.ac.at>
	<5a4c581d0610020521q721e3157q88ad17d3cc84a066@mail.gmail.com>
	<20061002124613.GB13984@gamma.logic.tuwien.ac.at>
	<20061002165053.GA2986@gamma.logic.tuwien.ac.at>
	<1159808304.2834.89.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Oct 2006 12:58:24 -0400
Dan Williams <dcbw@redhat.com> wrote:

> On Mon, 2006-10-02 at 18:50 +0200, Norbert Preining wrote:
> > On Mon, 02 Okt 2006, Norbert Preining wrote:
> > > > The main features of the latest beta is WE-21 support (long/short
> > > > retry, power saving level, modulation), enhanced command line parser
> > > > in iwconfig, scanning options, more WPA support and more footprint
> > > > reduction tricks
> > > 
> > > Bingo. I build the new 29-pre10 and everything is working.
> > 
> > Sorry, that was over-optimistic. still same behaviour as with the Debian
> > v28 version.
> > 
> > The last character is cut of from wpa_supplicant. I have to set the
> > essid by hadn with
> > 	"real-essid "
> > mark the space at the end!
> 
> You have a mismatch between your wireless-tools, your kernel, and/or
> wpa_supplicant.  WE-21 uses the _real_ ssid length rather than the
> kludge of hacking off the last byte used previously.  Please ensure that
> your tools, driver, and kernel are using WE-21.
> 'cat /proc/net/wireless' should tell you what your kernel is using.
> Getting the driver WE is a bit harder and you may have to look at the
> source.

Jean, John: the amount of trouble which this change is causing is quite
high considering that we're not even at -rc1 yet.  It's going to get worse.

It doesn't sound like it'll be too hard to arrange for the kernel to
continue to work correctly with old userspace?
