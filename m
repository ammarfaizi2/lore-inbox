Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265653AbTF2NN5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 09:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbTF2NN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 09:13:57 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:12424 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S265653AbTF2NN4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 09:13:56 -0400
Date: Sun, 29 Jun 2003 14:28:07 +0100
From: Jamie Lokier <jamie@shareable.org>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org, mlmoser@comcast.net
Subject: Re: File System conversion -- ideas
Message-ID: <20030629132807.GA25170@mail.jlokier.co.uk>
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
I think
> the performance of an on-the-fly filesystem conversion utility is
> going to be so much worse than just creating a new partition and
> copying the data across,

which is awfully difficult if you have, say, a 60GB filesystem, a 60GB
disk, and nothing else.

> that the only reason to do it would be if you
> could do it on a read-write filesystem without unmounting it.

IMHO even if it requires the filesystem to be unmounted, it would
still be useful.  More challenging to use - you'd have to boot and run
from ramdisk, but much more useful than not being able to convert at all.

> What I'd like to see is union mounts which allowed you to mount a new
> filesystem of a different type over the original one, and have all new
> writes go to the new fileystem.  I.E. as files were modified, they
> would be re-written to the new FS.  That would be one way of avoiding
> the performance hit on a busy server.

But useless unless you have a second disk lying around that you don't
use for anything but filesystem conversions.

-- Jamie
