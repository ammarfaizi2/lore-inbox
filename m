Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269325AbUHZS6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269325AbUHZS6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269280AbUHZS5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:57:45 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:52486 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269325AbUHZS3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:29:13 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: silent semantic changes with reiser4
Date: Thu, 26 Aug 2004 21:28:41 +0300
User-Agent: KMail/1.5.4
Cc: Diego Calleja <diegocg@teleline.es>, <jamie@shareable.org>,
       <christophe@saout.de>, <christer@weinigel.se>, <spam@tnonline.net>,
       <akpm@osdl.org>, <wichert@wiggy.net>, <jra@samba.org>,
       <reiser@namesys.com>, <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <flx@namesys.com>,
       <reiserfs-list@namesys.com>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408262128.41326.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 August 2004 20:57, Rik van Riel wrote:
> On Thu, 26 Aug 2004, Linus Torvalds wrote:
> > > So all I need to do is "cat /bin | gzip -9 > /path/to/backup.tar.gz" ?
> >
> > No no. The stream you get from a directory is totally _independent_ of
> > the contents of the directory. Anything else would be pointless.
>
> It's a relief to know that nobody's taking my humorous
> suggestion seriously, but now we still have the "standard
> Unix tools can't manipulate files" problem...

Is it possible to sufficiently hide "dirs inside files"
so that old tools will be unable to see them?

I just checked:

ls -d /foo  does lstat64("/foo", ...)
ls -d /foo/ does lstat64("/foo", ...)
	but
ls -d /foo/. does lstat64("/foo/.", ...)

Will it work out if "dir inside file" will only be visible when referred as "file/."?
--
vda

