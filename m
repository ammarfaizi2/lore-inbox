Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbTJGQGe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 12:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbTJGQGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 12:06:33 -0400
Received: from quechua.inka.de ([193.197.184.2]:59358 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262457AbTJGQGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 12:06:32 -0400
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: devfs vs. udev
Date: Tue, 07 Oct 2003 18:06:53 +0200
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2003.10.07.16.06.52.842471@dungeon.inka.de>
References: <yw1xad8dfcjg.fsf@users.sourceforge.net> <pan.2003.10.07.13.41.23.48967@dungeon.inka.de> <yw1xekxpdtuq.fsf@users.sourceforge.net> <20031007142349.GX1223@rdlg.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Oct 2003 14:26:07 +0000, Robert L. Harris wrote:
> I just hope udev can give a look/feel similar to devfs as I have quite a
> few machines already in production configured for devfs and really like
> the manageablility.

I wonder: do you use the /dev/disc/* links, or the /dev/ide/... and
/dev/scsi/... constructs? I'm not sure how udev will be able to 
support both layouts.

Also: do you prefer a devs compatible layout, or maybe use the change
for a cleanup? a short list of obscurities: /dev/cdroms/cdrom0 but
/dev/printers/0 and /dev/tts/0 and /dev/floppy but /dev/discs etc. also
all floppy devices are in /dev/floopy, where each disc has is
/dev/discs/discN directory/symlink. I think it's a good opportunity
for a cleanup, but that wouldn't be compatible...

Regards, Andreas

