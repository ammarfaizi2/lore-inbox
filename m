Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264089AbTHVTyr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 15:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264100AbTHVTyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 15:54:47 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:11486 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S264089AbTHVTyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 15:54:45 -0400
Date: Fri, 22 Aug 2003 21:54:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: Christoph Hellwig <hch@infradead.org>, davej@codemonkey.org.uk,
       kernel list <linux-kernel@vger.kernel.org>, paul.devriendt@amd.com,
       aj@suse.de
Subject: Re: Cpufreq for opteron
Message-ID: <20030822195427.GB2306@elf.ucw.cz>
References: <20030822135946.GA2194@elf.ucw.cz> <20030822155207.A17469@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030822155207.A17469@infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +/* driver entry point for term */
> > +static void __exit
> > +drv_exit(void)
> > +{
> > +	dprintk(KERN_INFO PFX "drv_exit\n");
> > +
> > +	cpufreq_unregister_driver(&cpufreq_amd64_driver);
> > +	if (ppst) {
> > +		kfree(ppst);
> 
> kfree(NULL) is fine.
> 
> > +		ppst = 0;
> 
> this should be ppst = NULL but in fact is completly superflous as
> the module is gone afterwards.

Ok.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
