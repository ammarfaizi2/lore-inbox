Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbTKVRRG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 12:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbTKVRRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 12:17:06 -0500
Received: from web41906.mail.yahoo.com ([66.218.93.157]:55170 "HELO
	web41906.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262529AbTKVRPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 12:15:50 -0500
Message-ID: <20031122171548.3020.qmail@web41906.mail.yahoo.com>
Date: Sat, 22 Nov 2003 09:15:48 -0800 (PST)
From: Michael Welles <mikewelles71@yahoo.com>
Subject: Re: Using get_cwd inside a module.
To: Christoph Hellwig <hch@infradead.org>, Juergen Hasch <lkml@elbonia.de>
Cc: Michael Welles <mike@bangstate.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20031122101559.A30932@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Christoph Hellwig <hch@infradead.org> wrote:

> Well, you can't return filenames.  There's no unique
> path to a give
> file. 
> 
> What are the exact requirements of changedfiles or
> samba?

For changedfiles, essentially a device special that
reports file operations, e.g.

OPENW /home/foo/filename
MKDIR /home/foo/bar
RENAME /home/foo/bar -> /home/foo/goo

The userspace deamon reads the operations and files,
and compares then to regexp rules in the config file
i.e, for an automatic image converter:

RULE ^/home/dropbox/*.gif
SHELL /usr/bin/convert __FILE__ `basename __FILE__
.jpg`

It also does in process FTP, so you can do poor man's
replication to a remote machine without the overhead
of polling.




__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/
