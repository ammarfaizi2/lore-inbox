Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263594AbTDNSWv (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTDNSPL (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:15:11 -0400
Received: from s161-184-77-200.ab.hsia.telus.net ([161.184.77.200]:51163 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S263636AbTDNSEa convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 14:04:30 -0400
Date: Mon, 14 Apr 2003 12:16:13 -0600 (MDT)
From: James Bourne <jbourne@hardrock.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Martin Schlemmer <azarah@gentoo.org>,
       Ken Brownfield <brownfld@irridia.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       KML <linux-kernel@vger.kernel.org>
Subject: Re: Oops: ptrace fix buggy
In-Reply-To: <20030414172111.GI10347@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.44.0304141133370.24506-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Apr 2003, Jörn Engel wrote:

> On Mon, 14 April 2003 11:09:02 -0600, James Bourne wrote:
> > 
...
> > will need to be looked at as these are ones which contain references to
> > SUBVERSION...  References to EXTRAVERSION also reside in these files.  It
> > would just be better to do the "right thing" IMHO.
> > 
> > I will take a look at this and produce a patch for the same.
> 
> Ok. But the patch I lost really didn't do anything else and works for
> me (TM).
> 
> joern@Limerick:~$ uname -a
> Linux Limerick 2.4.20.1-je1 #3 Sun Apr 6 22:20:45 CEST 2003 i686 unknown unknown GNU/Linux
> joern@Limerick:~$ 

Hi,
The problem comes in when you bump the FIXLEVEL for example, by one.  At
that point the LINUX_VERSION_CODE would not change even though you have a
new kernel and modules compiled for the previous version may not load or
may load and not work correctly (just one example).

EXTRAVERSION on the other hand is not used for LINUX_VERSION_CODE
calculation.  

Regards
James Bourne

> Jörn

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  

