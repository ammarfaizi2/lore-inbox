Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272243AbTG3VDF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 17:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272249AbTG3VDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 17:03:05 -0400
Received: from windsormachine.com ([206.48.122.28]:49424 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S272243AbTG3VC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 17:02:59 -0400
Date: Wed, 30 Jul 2003 17:02:47 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Disk performance degradation
In-Reply-To: <3F26A5E2.4070701@aros.net>
Message-ID: <Pine.LNX.4.56.0307301658030.30842@router.windsormachine.com>
References: <20030729182138.76ff2d96.lista1@telia.com> <3F26A5E2.4070701@aros.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003, Lou Langholtz wrote:

> Anyone want to field why we aren't we just setting the default to 512 so
> users don't need to adjust this? I'm sure there's a good reason... I'd
> just like to know what it is ;-)

mike:~# hdparm -a 512 /dev/hda

/dev/hda:
 setting fs readahead to 512
 BLKRASET failed: Invalid argument
 readahead    =  8 (on)

mike:~# hdparm -a 255 /dev/hda

/dev/hda:
 setting fs readahead to 255
 readahead    = 255 (on)

mike:~# hdparm -a 256 /dev/hda

/dev/hda:
 setting fs readahead to 256
 BLKRASET failed: Invalid argument
 readahead    = 255 (on)

Probably for reasons like that.  For some reason, I can't set my ICH4
based controller(ASUS P4B533) and Quantum Fireball AS40.0 to more than
255.  Kernel is 2.4.21

Or I'm missing more of this thread than I thought and I'm completely off
topic here!

(i'm guessing the latter)

Mike
