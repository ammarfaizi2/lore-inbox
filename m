Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265284AbTL0ApJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 19:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbTL0ApJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 19:45:09 -0500
Received: from [141.154.95.10] ([141.154.95.10]:32641 "EHLO peabody.ximian.com")
	by vger.kernel.org with ESMTP id S265284AbTL0ApE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 19:45:04 -0500
Subject: Re: Can't eject a previously mounted CD?
From: Rob Love <rml@ximian.com>
To: Matt <dirtbird@ntlworld.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3FECD2FB.4070008@ntlworld.com>
References: <3FECD2FB.4070008@ntlworld.com>
Content-Type: text/plain
Message-Id: <1072485880.4136.1.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Fri, 26 Dec 2003 19:44:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-26 at 19:31, Matt wrote:
> If you are on debian i have noticed recently that gnomevfs (on unstable) 
> requires famd. famd will open /cdrom after it is mounted and run a dir 
> notification on it. now i think famd needs some fixing, firstly to not 
> bother running dir notice on ro filesystems, and secondly allow an 
> authorised user (other than the original program (in this case 
> nautilus)) to drop specific mount point dirs from the notification list. 
> so yes this is a userland problem as far as i can see.

Yup.

But it sure is lame that our directory notification system (dnotify)
needs to hold open a file descriptor on the directory, and thus really
wrecks havoc on removable media.

Would be nice to have a saner replacement - for other reasons, too.

	Rob Love


