Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTHVWU4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 18:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTHVWU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 18:20:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:63962 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262874AbTHVWUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 18:20:54 -0400
Date: Fri, 22 Aug 2003 15:13:47 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@suse.cz>
cc: <torvalds@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs
 explaining to you?
In-Reply-To: <20030822221025.GE2306@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0308221512360.2310-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > >  static int __init resume_setup(char *str)
> > >  {
> > > -	strncpy( resume_file, str, 255 );
> > > +	if (strlen(str))
> > > +		strncpy(resume_file, str, 255);
> > >  	return 1;
> > >  }
> > > 
> > > Why are you obfuscating the code?
> > 
> > Eh? First, why would you want to copy a NULL string? 
> 
> How is strlen(NULL) better than strncpy(_, NULL, _)?

Well, it will tell you whether or not you copied anything. Which, like I 
mentioned before, can be used to determine whether or not the user really 
wants to resume or not, in lieu of a superfluous command line parameter 
("noresume"). 


	Pat

