Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbUBOAIn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 19:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUBOAHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 19:07:50 -0500
Received: from [212.28.208.94] ([212.28.208.94]:9740 "HELO dewire.com")
	by vger.kernel.org with SMTP id S263661AbUBOAH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 19:07:28 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: JFS default behavior
Date: Sun, 15 Feb 2004 01:07:26 +0100
User-Agent: KMail/1.6.1
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402150107.26277.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 February 2004 00.29, you wrote:
> On Sun, Feb 15, 2004 at 12:06:23AM +0100, Robin Rosenberg wrote:
> > The  "sequence of bytes" idea is a legacy from prehistoric times when byte == character
> > was true.
> 
> Bullshit.  It has _nothing_ to characters, wide or not.  For system filenames
> are opaque.  The only things that have special meanings are:
> 	octet 0x2f ('/') splits the pathname into components
> 	"." as a component has a special meaning
> 	".." as a component has a special meaning.
> That's it.  The rest is never interpreted by the kernel.
I know how it is (to some degree), and its wrong. The user sees inside the filename
and sees a string of characters, not a byte sequence.

> Try to realize that different users CAN HAVE DIFFERENT LOCALES.  On the same
> system.  And have files on the same fs.  Moreover, homedirs that used to be
> on different filesystems can end up one the same fs.  What iocharset would
> you use, then?  Sigh...
Ok, I've got the iocharset option wrong, god knows why. The problem 
however remains.

It seems you simply don't want to understand the problem, which is that users 
CAN HAVE DIFFERENT LOCALES on the same system and on different system. 
Sigh...

I less concerned with which solution than that a solution should be found. So it
seems no file system has a solution today. Still an iocharset option would relieve
the problem for removable media and muli-boot systems. Most linux machines
are essentially single user and have either the same locale for all users or all
users are using UTF-8 with their locale. It's not the locale, but the charset used
for encoding the locale. The rest cannot be helped.

-- robin
