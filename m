Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUGMBoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUGMBoz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 21:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUGMBoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 21:44:55 -0400
Received: from quechua.inka.de ([193.197.184.2]:50078 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261239AbUGMBox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 21:44:53 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20040712225338.GD23623@taniwha.stupidest.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BkCLk-0000eo-00@calista.eckenfels.6bone.ka-ip.net>
Date: Tue, 13 Jul 2004 03:44:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040712225338.GD23623@taniwha.stupidest.org> you wrote:
> To be quite honest I've never seen nulls in files that a days old, and
> I have scripts which checksum (md5) my files (hundreds of gigabytes)
> which would notice this, so knowing how to reproduce it would be nice.

I can say, that nulls in files are most common at the end of (sys)log files
filing up to the next block boundary. I always asumed this is due to the
fact that the filesize in the metadata was not written but the last
half-finished block was already linked in the inode structure.

I have never seen null  filled data or config files other than that, but I
do not have busy servers crashing often on me.

> Log was being appended, system crashed, you get nulls at the end when
> rebootd, the logger opens the file append and starts writing stuff,
> the nulls end up in the middle.  Arguably this is expected.

Yes, and it is normally easy to spot, since the messages after the nulls are
boot messages.

> see the nulls.  I'm pretty sure for you the nulls are not really
> on-disk, looking at the raw device you won't see them.  They nulls are
> returns for unwritten extents just as nulls are returned for holes in
> sparse files.

ls -s compared with ls -l should make that visible?

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
