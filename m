Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVCNWYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVCNWYG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVCNWU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:20:29 -0500
Received: from isilmar.linta.de ([213.239.214.66]:6090 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262033AbVCNWRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:17:37 -0500
Date: Mon, 14 Mar 2005 23:17:36 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Paulo Marques <pmarques@grupopie.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: inconsistent kallsyms data [2.6.11-mm2]
Message-ID: <20050314221736.GB13378@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Paulo Marques <pmarques@grupopie.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050308033846.0c4f8245.akpm@osdl.org> <20050308192900.GA16882@isilmar.linta.de> <20050308123554.669dd725.akpm@osdl.org> <20050308204521.GA17969@isilmar.linta.de> <422EF2B0.7070304@grupopie.com> <422F59A3.9010209@grupopie.com> <423039A6.5010301@grupopie.com> <20050313085441.GA24006@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050313085441.GA24006@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2005 at 09:54:41AM +0100, Sam Ravnborg wrote:
> On Thu, Mar 10, 2005 at 12:12:22PM +0000, Paulo Marques wrote:
> > Paulo Marques wrote:
> > >[...]
> > >A simple and robust way is to do the sampling on a list of symbols 
> > >sorted by symbol name. This way, even if the symbol positions that are 
> > >given to scripts/kallsyms change, the symbols sampled will be the same.
> > >
> > >I'll do the patch to do this and send it ASAP.
> > 
> > Ok, here it is.
> > 
> > Dominik can you try the attached patch and see if it solves the problem?
> Hi Paulo.
> 
> Alexander Stohr had similar problems with down and __sched_text_start.
> 
> I figured out that what was causing the troubles was the fact that the
> linker generated symbol __sched_text_start changed value from pass 1 to
> pass 2. The reason for this was the alingment used within that section.
> 
> My stamp on this is attached.
> 
> I never came around submitting this since I do not know what the correct
> number for function alignment is on different paltforms.

This patch fixes it on my (x86) system. 

Thanks,
	Dominik
