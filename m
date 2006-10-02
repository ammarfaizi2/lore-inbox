Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWJBQ4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWJBQ4j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 12:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWJBQ4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 12:56:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22741 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932116AbWJBQ4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 12:56:39 -0400
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
From: Dan Williams <dcbw@redhat.com>
To: Norbert Preining <preining@logic.at>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Andrew Morton <akpm@osdl.org>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, ipw3945-devel@lists.sourceforge.net
In-Reply-To: <20061002165053.GA2986@gamma.logic.tuwien.ac.at>
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at>
	 <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com>
	 <20061002113259.GA8295@gamma.logic.tuwien.ac.at>
	 <5a4c581d0610020521q721e3157q88ad17d3cc84a066@mail.gmail.com>
	 <20061002124613.GB13984@gamma.logic.tuwien.ac.at>
	 <20061002165053.GA2986@gamma.logic.tuwien.ac.at>
Content-Type: text/plain; charset=utf-8
Date: Mon, 02 Oct 2006 12:58:24 -0400
Message-Id: <1159808304.2834.89.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-6.fc6) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 18:50 +0200, Norbert Preining wrote:
> On Mon, 02 Okt 2006, Norbert Preining wrote:
> > > The main features of the latest beta is WE-21 support (long/short
> > > retry, power saving level, modulation), enhanced command line parser
> > > in iwconfig, scanning options, more WPA support and more footprint
> > > reduction tricks
> > 
> > Bingo. I build the new 29-pre10 and everything is working.
> 
> Sorry, that was over-optimistic. still same behaviour as with the Debian
> v28 version.
> 
> The last character is cut of from wpa_supplicant. I have to set the
> essid by hadn with
> 	"real-essid "
> mark the space at the end!

You have a mismatch between your wireless-tools, your kernel, and/or
wpa_supplicant.  WE-21 uses the _real_ ssid length rather than the
kludge of hacking off the last byte used previously.  Please ensure that
your tools, driver, and kernel are using WE-21.
'cat /proc/net/wireless' should tell you what your kernel is using.
Getting the driver WE is a bit harder and you may have to look at the
source.

Dan

> 
> Best wishes
> 
> Norbert
> 
> -------------------------------------------------------------------------------
> Dr. Norbert Preining <preining@logic.at>                    Università di Siena
> Debian Developer <preining@debian.org>                         Debian TeX Group
> gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
> -------------------------------------------------------------------------------
> MELCOMBE REGIS (n.)
> The name of the style of decoration used in cocktail lounges in mock
> Tudor hotels in Surrey.
> 			--- Douglas Adams, The Meaning of Liff
> _______________________________________________
> HostAP mailing list
> HostAP@shmoo.com
> http://lists.shmoo.com/mailman/listinfo/hostap

