Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbUBVTWG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 14:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbUBVTWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 14:22:06 -0500
Received: from h24-82-88-106.vf.shawcable.net ([24.82.88.106]:25475 "HELO
	tinyvaio.nome.ca") by vger.kernel.org with SMTP id S261730AbUBVTWE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 14:22:04 -0500
Date: Sun, 22 Feb 2004 11:22:39 -0800
From: kernel@mikebell.org
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior / UTF-8 filenames
Message-ID: <20040222192237.GC540@tinyvaio.nome.ca>
References: <1076886183.18571.14.camel@m222.net81-64-248.noos.fr> <20040219105913.GE432@tinyvaio.nome.ca> <1077199506.2275.12.camel@shaggy.austin.ibm.com> <20040219234746.GG432@tinyvaio.nome.ca> <1077289257.2533.23.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077289257.2533.23.camel@shaggy.austin.ibm.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 09:00:58AM -0600, Dave Kleikamp wrote:
> With no iocharset specified, a filename with such a character will be
> inaccessible.  Probably the best thing for readdir to do is to
> substitute a '?' and print a message to the syslog to mount the volume
> with iocharset=utf8 to be able to access the file.  Of course I would
> limit the number of printk's to something small.  I'll submit a patch to
> do this.

And that's why I was saying I think UTF-8 mode is the "least broken" for
any filesystem that stores filenames in a specific encoding rather than
"as the client submitted it". And most especially for UCS-2/UTF-16
filesystems.

I think the default for a filesystem should be something that absolutely
will not disappear your files. So for NTFS/JFS, it should be UTF-8. And
if a traditional UNIX filesystem wants to do a UTF-8 only mode, I think
ideally it should be done at mkfs time rather than mount time.
