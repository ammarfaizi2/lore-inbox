Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265964AbUEUSFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265964AbUEUSFL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 14:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265965AbUEUSFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 14:05:11 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:3257 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S265964AbUEUSFF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 14:05:05 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp: fix devfs breakage introduced in 2.6.6
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 21 May 2004 20:05:01 +0200
Message-ID: <xb7y8nlirle.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pavel" == Pavel Machek <pavel@ucw.cz> writes:

    Pavel> Hi!  This fixes bad interaction between devfs and swsusp.

    Pavel>  Check whether the swap device is the specified resume
    Pavel> device, irrespective of whether they are specified by
    Pavel> identical names.

    Pavel>  (Thus, device inode aliasing is allowed.  You can say
    Pavel> /dev/hda4 instead of /dev/ide/host0/bus0/target0/lun0/part4
    Pavel> [if using devfs] and they'll be considered the same device.
    Pavel> This is *necessary* for devfs, since the resume code can
    Pavel> only recognize the form /dev/hda4, but the suspend code
    Pavel> would like the long name [as shown in 'cat /proc/mounts'].)

    Pavel> [Thanks to devfs hero whose name I forgot.]  Pavel

The patch  was submitted by  me.  But I'm  no devfs hero at  all.  I'm
just a  happy user of devfs who  gets unhappy due to  this swsusp bug.
:)



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

