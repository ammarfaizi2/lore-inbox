Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263867AbTDNVHr (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbTDNVHr (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:07:47 -0400
Received: from s161-184-77-200.ab.hsia.telus.net ([161.184.77.200]:56284 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S263867AbTDNVHp convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 17:07:45 -0400
Date: Mon, 14 Apr 2003 15:19:27 -0600 (MDT)
From: James Bourne <jbourne@hardrock.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Martin Schlemmer <azarah@gentoo.org>,
       Ken Brownfield <brownfld@irridia.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       KML <linux-kernel@vger.kernel.org>
Subject: Re: Oops: ptrace fix buggy
In-Reply-To: <20030414185806.GA12740@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.44.0304141515080.24383-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Apr 2003, Jörn Engel wrote:

> So basically, neither the existing EXTRAVERSION nor my new FIXLEVEL
> are checked. Any code could potentially break with -ac1 to -ac2 or
> with .1 to .2.
> 
> Did anyone experience such problems with -ac already? There are far
> more changes in -ac than there are in your patch.

Which brings the point as to why use a new variable unless you are going to
actually modify LINUX_VERSION_CODE with it.  It actually makes more sense to
just use EXTRAVERSION for this then.

Now, using EXTRAVERSION = .2 wouldn't be unrealistic...

Regards
James Bourne

> 
> Driver compilation should not be an issue. Change the Makefile and
> version.h should be changed as well, so any code depending on
> version.h will be rebuild, whether necessary or not.
> 
> Module load sounds unrealistic for .[123...], as you shouldn't change
> any interfaces with fixes. But it might be a real problem for -ac.
> 
> Jörn
> 
> PS: Or for -aa, -dj, -mm or whatever. It's just an example.
> 
> 

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  


