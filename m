Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbVE0K3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbVE0K3N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 06:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVE0K3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 06:29:13 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:6610 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262422AbVE0K27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 06:28:59 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc5-mm1
Date: Fri, 27 May 2005 12:29:01 +0200
User-Agent: KMail/1.8
Cc: jamagallon@able.es, tomlins@cam.org, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net
References: <20050525134933.5c22234a.akpm@osdl.org> <200505261554.54807.rjw@sisk.pl> <20050526134532.1580defc.akpm@osdl.org>
In-Reply-To: <20050526134532.1580defc.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200505271229.01699.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 26 of May 2005 22:45, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > n Thursday, 26 of May 2005 09:58, Andrew Morton wrote:
> >  > "J.A. Magallon" <jamagallon@able.es> wrote:
> >  > >
> >  > > 
> >  > > On 05.26, Andrew Morton wrote:
> >  > > > 
> >  > > > (Added alsa-devel to cc)
> >  > > > 
> >  > > > Ed Tomlinson <tomlins@cam.org> wrote:
> >  > > > > 
> >  > > > > Got the following when I tried to use sound.  Anyone else see problems in alsa land?
> >  > > > > 
> >  > > 
> >  > > Me too. As beep-media-player ends playing a mp3 track, oops !
> >  > 
> >  > hm, OK, you're also on x86_64.  What sound card and driver?
> > 
> >  I've got the following on a dual-Opteron box with Tyan Thunder K8W (snd_intel8x0):
> 
> OK, thanks.  I guess we can set this problem aside for now, as this bug
> isn't present in 2.6.12-rc5 (correct?).

Yup.

> I assume the problem is due to one of the ASLA patches in rc5-mm1, but it's
> possible that it lies elsewhere.

Well, yes.  Apparently, it goes away if you revert the following patch:

avoiding-mmap-fragmentation-fix-2.patch

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
