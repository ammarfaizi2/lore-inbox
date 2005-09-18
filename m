Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbVIRERx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbVIRERx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 00:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVIRERx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 00:17:53 -0400
Received: from dial169-234.awalnet.net ([213.184.169.234]:54020 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S1751300AbVIRERx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 00:17:53 -0400
From: Al Boldi <a1426z@gawab.com>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: Eradic disk access during reads
Date: Sun, 18 Sep 2005 07:16:46 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200509170717.03439.a1426z@gawab.com> <200509171323.53054.a1426z@gawab.com> <20050917184643.GA1313@alpha.home.local>
In-Reply-To: <20050917184643.GA1313@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509180716.46978.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Sat, Sep 17, 2005 at 01:32:53PM +0300, Al Boldi wrote:
> > Willy Tarreau wrote:
> > > On Sat, Sep 17, 2005 at 07:26:11AM +0300, Al Boldi wrote:
> > > > Monitoring disk access using gkrellm, I noticed that a command like
> > > >
> > > > cat /dev/hda > /dev/null
> > > >
> > > > shows eradic disk reads ranging from 0 to 80MB/s on an otherwise
> > > > idle system.

New synonym: eradic=erratic :)

> Denis' tool seems clearly more suited to analyse your problem.

The problem seems to be a multi-access collision in the queue, which forces a 
~50% reduction of thruput, which recovers with another multi-access 
collision.  Maybe?!

--
Al

