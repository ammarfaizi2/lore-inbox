Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbUCILcN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 06:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUCILcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 06:32:13 -0500
Received: from zork.zork.net ([64.81.246.102]:40083 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261876AbUCILcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 06:32:11 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Bind Mount Extensions (RO --bind mounts)
References: <404DA061.8000806@infini.fr>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Tue, 09 Mar 2004 11:32:10 +0000
In-Reply-To: <404DA061.8000806@infini.fr> (Olivier ARCHER's message of "Tue,
 09 Mar 2004 11:45:53 +0100")
Message-ID: <6ullmajlxh.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier ARCHER <olivier.archer@infini.fr> writes:

> Hi,
> 	I've tried
> http://www.ussg.iu.edu/hypermail/linux/kernel/0309.3/0802.html
> to try the 'Bind Mount Extensions (RO --bind mounts)'
>
> I've applied the patch on 2.4.24 and 2.6.3, without effects, ie
>
> mount -t ext2 -o ro /dev/hdc7 /mnt/ro
> mount --bind -o rw /mnt/ro /mnt/ro2rw
> touch  /mnt/ro2rw/test
> touch: connot touch '/mnt/ro2rw/test': Read Only file system
>
> have I miss something ?

As far as I can tell, you have it backwards.  BME seems to be designed
to enable you to do ro binds of an rw FS, not an rw bind of an ro FS.

