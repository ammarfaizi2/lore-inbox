Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbSKTRGs>; Wed, 20 Nov 2002 12:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSKTRGs>; Wed, 20 Nov 2002 12:06:48 -0500
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:16929 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S261518AbSKTRGA>; Wed, 20 Nov 2002 12:06:00 -0500
Message-ID: <61DB42B180EAB34E9D28346C11535A78011301DC@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'Rus Foster'" <rghf@fsck.me.uk>, linux-kernel@vger.kernel.org
Subject: RE: Patching 2.5.xx
Date: Wed, 20 Nov 2002 12:12:23 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hi All,
> I've decided to start trying out the 2.5 kernels and I've got 
> the 2.5.47
> tarball and the 2.5.48 patch. However looking at the diff 
> file its trying
> to create an a and b directory. Is there a special 
> significance for this
> and how do I go about applying the patch?
> 

`man patch` would be your friend here:

       -pnum  or  --strip=num
          Strip the smallest prefix containing num leading  slashes  from
each  file  name
          found  in  the patch file.  A sequence of one or more adjacent
slashes is counted
          as a single slash.  This controls how file names found  in  the
patch  file  are
          treated, in case you keep your files in a different directory than
the person who
          sent out the patch.  For example, supposing the file name in the
patch file was

             /u/howard/src/blurfl/blurfl.c

          setting -p0 gives the entire file name unmodified, -p1 gives

             u/howard/src/blurfl/blurfl.c

          without the leading slash, -p4 gives

             blurfl/blurfl.c

          and not specifying -p at all just gives you blurfl.c.  Whatever
you end  up  with
          is  looked for either in the current directory, or the directory
specified by the
          -d option.
