Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267601AbSLFFOC>; Fri, 6 Dec 2002 00:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267600AbSLFFOC>; Fri, 6 Dec 2002 00:14:02 -0500
Received: from gbmail.cc.gettysburg.edu ([138.234.4.100]:18909 "EHLO
	gettysburg.edu") by vger.kernel.org with ESMTP id <S267601AbSLFFOC>;
	Fri, 6 Dec 2002 00:14:02 -0500
Date: Fri, 6 Dec 2002 00:21:32 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: attempt to access beyond end of device
Message-ID: <20021206052132.GA3952@perseus.homeunix.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before anyone asks, no my disk is not full:

pryzbyj@perseus:/usr/src/penguin$ df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/hda1             3.7G  1.1G  2.5G  31% /
/dev/hda3              19G  349M   18G   2% /home
/dev/hda4              14G  1.5G   12G  12% /usr/src

Sizes shouldn't have changed by more than 01% since I got the error.
Interesting: rerunning `updatedb --localuser=nobody 2>/dev/null` fails to
reproduce the error.

Is the error possibly the result of filesystem corruption?  I imagine that
each directory has a pointer to the disk location of each of its member
files; if that pointer were larger than the disk size, would this error
be the result?

If this is the result of filesystem corruption, it is not necessarily a
problem with ext3 or some othersuch, as I have done some *hard* shutdowns
recently (read: control-alt-backspace on a sis motherboard).

Justin
