Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264545AbTEPSaV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 14:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbTEPSaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 14:30:21 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:50914 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264545AbTEPSaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 14:30:20 -0400
Subject: Re: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Ben Collins <bcollins@debian.org>
Cc: Patrick Mochel <mochel@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030516002059.GE433@phunnypharm.org>
References: <20030513071412.GS433@phunnypharm.org>
	 <Pine.LNX.4.44.0305130808040.9816-100000@cherise>
	 <20030516002059.GE433@phunnypharm.org>
Content-Type: text/plain
Message-Id: <1053110581.648.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 16 May 2003 20:43:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-16 at 02:20, Ben Collins wrote:
> On Tue, May 13, 2003 at 08:08:35AM -0700, Patrick Mochel wrote:
> > 
> > On Tue, 13 May 2003, Ben Collins wrote:
> > 
> > > On Tue, May 13, 2003 at 08:10:32AM +0100, Christoph Hellwig wrote:
> > > > On Tue, May 13, 2003 at 02:26:40AM -0400, Ben Collins wrote:
> > > > > This was causing me all sorts of problems with linux1394's 16-18 byte
> > > > > long bus_id lengths. The sysfs names were all broken.
> > > > > 
> > > > > This not only makes KOBJ_NAME_LEN match BUS_ID_SIZE, but fixes the
> > > > > strncpy's in drivers/base/ so that it can't happen again (atleast the
> > > > > strings will be null terminated).
> > > > 
> > > > What about defining BUS_ID_SIZE in terms of KOBJ_NAME_LEN?
> > > 
> > > Ok, then add this in addition to the previous patch.
> > 
> > I'll add this, and sync with Linus this week, if he doesn't pick it up.
> 
> *sigh* Patrick, you accepted the BUS_ID_SIZE change without the original
> patch, so now BUS_ID_SIZE is back to 16 bytes.
> 
> Linus, please apply this patch to get things right again.

Well, it seems this patch has bad interaction with the Yamaha ALSA sound
driver (aka snd-ymfpci). Don't know why, but changing KOBJ_NAME_LEN from
16 to 20, causes snd-ymfpci.ko to oops.

If you have the time, please take a look at another thread in the LKML
called "pccard oops while booting".

