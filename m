Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbTJNKKb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 06:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbTJNKKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 06:10:31 -0400
Received: from users.linvision.com ([62.58.92.114]:33177 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262099AbTJNKKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 06:10:25 -0400
Date: Tue, 14 Oct 2003 12:10:21 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Hans Reiser <reiser@namesys.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, John Bradford <john@grabjohn.com>,
       Wes Janzen <superchkn@sbcglobal.net>, linux-kernel@vger.kernel.org
Subject: Re: Why are bad disk sectors numbered strangely, and what happens to them?
Message-ID: <20031014101021.GE16683@bitwizard.nl>
References: <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net> <200310140721.h9E7LmNE000682@81-2-122-30.bradfords.org.uk> <20031014074020.GC13117@bitwizard.nl> <200310140811.h9E8Bxq1000831@81-2-122-30.bradfords.org.uk> <3F8BB7AE.2040507@namesys.com> <20031014094629.GA16683@bitwizard.nl> <3F8BC896.6020106@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8BC896.6020106@namesys.com>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 01:57:42PM +0400, Hans Reiser wrote:
> Rogier Wolff wrote:
> >Of course, I left my drive that indicated it had problems (i.e. it
> >didn't spot the sector going bad before it became unreadable), in the
> >machine for another two days. It's getting replaced ASAP (i.e. the
> >next hour or so).

> replacing the drive is reasonable caution.  I think though that the 
> other poster is right that IFF you want to remap bad blocks, the drive 
> should do it not reiserfs.

It is a "pretty much for free" feature. In your in-kernel
implementation you hopefully already have the ability to skip blocks
in use by other files. So allocating it to a special file will take
care of the kernel part. Next you need one line in your fsck to
prevent that "dangling inode" getting linked into lost+found. Then you
do need a utility to actually be able to mark blocks as bad. 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
