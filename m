Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318355AbSGRVXs>; Thu, 18 Jul 2002 17:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318359AbSGRVXs>; Thu, 18 Jul 2002 17:23:48 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:42665 "EHLO
	postfix1-2.free.fr") by vger.kernel.org with ESMTP
	id <S318355AbSGRVXr>; Thu, 18 Jul 2002 17:23:47 -0400
Date: Thu, 18 Jul 2002 22:35:27 +0200
To: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: cdrom driver report wrong number of used blocks on multisession cdr
Message-ID: <20020718203527.GI19580@bylbo.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Yann Dirson <ydirson@altern.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I suppose it's an issue in the cdrom driver: df does not report the correct
number of used blocks on a multisession CD/R, only the number of blocks
used by the last session:

# df /cdrom/
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/cdrom                8022      8022         0 100% /cdrom

# du -sk /cdrom/
472679  /cdrom


I got the same behaviour under 2.2.19 and 2.4.18.

-- 
Yann Dirson    <ydirson@altern.org> |    Why make M$-Bill richer & richer ?
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
Pro:    <yann.dirson@fr.alcove.com> |  Freedom, Power, Stability, Gratuity
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
