Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284272AbRLMPk7>; Thu, 13 Dec 2001 10:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284282AbRLMPku>; Thu, 13 Dec 2001 10:40:50 -0500
Received: from chmls06.mediaone.net ([24.147.1.144]:7042 "EHLO
	chmls06.mediaone.net") by vger.kernel.org with ESMTP
	id <S284272AbRLMPka>; Thu, 13 Dec 2001 10:40:30 -0500
Date: Thu, 13 Dec 2001 10:27:29 -0500
To: Hans Reiser <reiser@namesys.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Nathan Scott <nathans@sgi.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: reiser4 (was Re: [PATCH] Revised extended attributes  interface)
Message-ID: <20011213102729.B3812@pimlott.ne.mediaone.net>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Nathan Scott <nathans@sgi.com>,
	Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <20011207202036.J2274@redhat.com> <20011208155841.A56289@wobbly.melbourne.sgi.com> <3C127551.90305@namesys.com> <20011211134213.G70201@wobbly.melbourne.sgi.com> <5.1.0.14.2.20011211184721.04adc9d0@pop.cus.cam.ac.uk> <3C1678ED.8090805@namesys.com> <20011212204333.A4017@pimlott.ne.mediaone.net> <3C1873A2.1060702@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C1873A2.1060702@namesys.com>
User-Agent: Mutt/1.3.23i
From: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2001 at 12:23:46PM +0300, Hans Reiser wrote:
> Andrew Pimlott wrote:
> >First, I write a desktop application that wants to save an HTML file
> >along with some other object that contains the name of the creating
> >application.  The latter can go anywhere you want, except in the
> >same stream as the HTML file.  The user has requested that the
> >filename be /home/user/foo.html , and expects to be able to FTP this
> >file to his ISP with a standard FTP program.  What calls does my
> >application make to store the HTML and the application name?  If the
> >answer is different depending on whether /home/user is NTFS or
> >reiserfs4, explain both ways.
> >
> Are you sure that standard ftp will be able to handle extended 
> attributes without modification?

No, the ftp program only needs to transfer the HTML part.

> One approach is to create a plugin called ..archive that when read is a 
> virtual file consisting of an archive of everything in the directory. 

Ok, does this mean that every directory in the filesystem (or in
some part of it) will automatically have a node ..archive?
Presumably, it will not appear in directory listings, but can be
read but not written to?  Does this mean that a legacy application
(pathological as it may be) that expects to be able to create a file
called ..archive will fail?

Or do you mean that the application would explicitly create the node
associated with this plugin?

> It would be interesting I think to attach said plugin to standard 
> directories by default along with several other standard plugins like 
> ..cat, etc.

Anyway, you didn't answer the part I really care about.  What calls
does the application make to store the HTML and the "extended
attribute"?  You can pick whatever conventions you want, just give
me an example.

> >Second, I booted NT and created a directory in the NTFS filesystem
> >called /foo .  In the directory, I created a file called bar.  I
> >also created a named stream called bar, and an extended attribute
> >called bar.  Now I boot Linux.  What calls do I make to see each of
> >the three objects called bar?
> >
> 
> You access /foo/bar, /foo/bar/,,bar, /foo/..bar by name.

How do I access the file called ..bar (created in NT) in the
directory /foo?

(Anton, does NTFS define any reserved filename characters, or only
win32?)

Andrew
