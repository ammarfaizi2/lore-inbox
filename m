Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbTHVWKh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 18:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbTHVWKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 18:10:37 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:30354 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S261158AbTHVWKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 18:10:33 -0400
Date: Sat, 23 Aug 2003 00:10:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: torvalds@osdl.org, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs explaining to you?
Message-ID: <20030822221025.GE2306@elf.ucw.cz>
References: <20030822210800.GA4403@elf.ucw.cz> <Pine.LNX.4.33.0308221411060.2310-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0308221411060.2310-100000@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  static int __init resume_setup(char *str)
> >  {
> > -	strncpy( resume_file, str, 255 );
> > +	if (strlen(str))
> > +		strncpy(resume_file, str, 255);
> >  	return 1;
> >  }
> > 
> > Why are you obfuscating the code?
> 
> Eh? First, why would you want to copy a NULL string? 

How is strlen(NULL) better than strncpy(_, NULL, _)?
							Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
