Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbVIQKgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbVIQKgD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 06:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbVIQKgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 06:36:03 -0400
Received: from dial170-161.awalnet.net ([213.184.170.161]:37380 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S1751045AbVIQKgC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 06:36:02 -0400
From: Al Boldi <a1426z@gawab.com>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: Eradic disk access during reads
Date: Sat, 17 Sep 2005 13:32:53 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200509170717.03439.a1426z@gawab.com> <20050917055010.GG30279@alpha.home.local>
In-Reply-To: <20050917055010.GG30279@alpha.home.local>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200509171323.53054.a1426z@gawab.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Sat, Sep 17, 2005 at 07:26:11AM +0300, Al Boldi wrote:
> > Monitoring disk access using gkrellm, I noticed that a command like
> >
> > cat /dev/hda > /dev/null
> >
> > shows eradic disk reads ranging from 0 to 80MB/s on an otherwise idle
> > system.
> >
> > 1. Is this a hardware or software problem?
>
> Difficult to tell without more info. Can be a broken IDE disk or defective
> ribbon.

Tried the same with 2.4.31 which shows steady behaviour with occasional dips 
and pops in the msec range.

>
> > 2. Is there a lightweight perf-mon tool (cmd-line) that would log this
> > behaviour graphically?
>
> You can do " readspeed </dev/hda | tr '\r' '\n' > log " with the readspeed
> tool from there :
>    http://w.ods.org/tools/readspeed

Does it have msec resolution?

Thanks!

--
Al
