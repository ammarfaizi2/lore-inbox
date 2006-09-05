Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWIELEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWIELEK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 07:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWIELEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 07:04:10 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24738 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751396AbWIELEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 07:04:07 -0400
Date: Tue, 5 Sep 2006 13:03:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: bcollins@debian.org, scjody@modernduck.com,
       linux1394-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: set power state of firewire host during suspend
Message-ID: <20060905110347.GA2052@elf.ucw.cz>
References: <20060905081426.GA4105@elf.ucw.cz> <44FD5342.1040207@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FD5342.1040207@s5r6.in-berlin.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Pavel Machek wrote:
> > --- a/drivers/ieee1394/ohci1394.c
> > +++ b/drivers/ieee1394/ohci1394.c
> > @@ -3565,6 +3565,7 @@ static int ohci1394_pci_suspend (struct 
> >  	}
> >  #endif
> >  
> > +	pci_set_power_state(pdev, pci_choose_state(pdev, state));
> >  	return 0;
> >  }
> >  
> > 
> 
> Does this work on PPC_PMAC? Note the platform code before #endif.
> http://www.linux-m32r.org/lxr/http/source/drivers/ieee1394/ohci1394.c?v=2.6.18-rc5-mm1#L3554


No idea, I know very little about PMACs. They still have PCI, right?
Why does it need hooks into drivers like this?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
