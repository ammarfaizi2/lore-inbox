Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275227AbTHRXkv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 19:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275229AbTHRXkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 19:40:51 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:8327
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S275227AbTHRXku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 19:40:50 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Antonio Vargas <wind@cocodriloo.com>
Subject: Re: [PATCH] O16.2int
Date: Tue, 19 Aug 2003 09:47:25 +1000
User-Agent: KMail/1.5.3
Cc: Tom Sightler <ttsig@tuxyturvy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1061152667.5526.26.camel@athxp.bwlinux.de> <1061169664.3f402a00ae7b6@kolivas.org> <20030818165102.GB7570@wind.cocodriloo.com>
In-Reply-To: <20030818165102.GB7570@wind.cocodriloo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308190947.26139.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 02:51, Antonio Vargas wrote:
> On Mon, Aug 18, 2003 at 11:21:04AM +1000, Con Kolivas wrote:
> > Quoting Tom Sightler <ttsig@tuxyturvy.com>:
> > > 2. -- Adobe Acrobat 5.07 for Linux seems to have a very similar issue,
> > > a large complex document seems to starve out the whole system making
> > > the system feel locked up for several seconds.
> >
> > Actually I've profiled acroread and it seems to be more a memory issue
> > than a scheduler one per se. Something very inefficient about it's design
> > and it behaves much worse as a mozilla plugin than standalone. Give it
> > lots of cpu time and it just keeps doing more and more vm work.
>
> Acrobat has a switch so that it keeps a cache of rendered pages, and
> obviously it default to ON, so just reading a big PDF file page by
> page will trash all the system with lots useless data. BUT, for simple
> PDF usage in a non-multitasking single-user machine it's faster
> so there you have a possible reason for it's strange behaviour.

Yes. As well as this though, there is a specific problem with it as a mozilla 
plugin. Profiling shows some libgdk is doing all the work and it really 
behaves badly. Put the same plugin into a different browser (eg opera) and it 
behaves well, working pretty much like standalone acroread. 

Con

