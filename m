Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267897AbUGaCRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267897AbUGaCRD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 22:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267900AbUGaCRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 22:17:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:36824 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267897AbUGaCQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 22:16:59 -0400
Date: Fri, 30 Jul 2004 19:08:25 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uid of user who mounts
Message-Id: <20040730190825.7a447429.rddunlap@osdl.org>
In-Reply-To: <1091239509.3894.11.camel@smfhome.smfdom>
References: <1091239509.3894.11.camel@smfhome.smfdom>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2004 21:05:09 -0500 Steve French wrote:

| To allow user unmounts of cifs shares (much like the setuid smbumount
| utility allows for smbfs), it has been suggested that the cifs vfs could
| return the uid of the mounter in /proc/mounts  This would avoid having
| to add an ioctl (as smbfs did) and seems as secure as the ioctl approach
| (to get the uid of the original mounter).
| 
| If user mounts are allowed, is there any worse security exposure in
| letting the tool check the uid who mounted via /proc/mounts (to allow
| user unmount).   
| 
| Is there any precedent for the name for the name of such a parm?  I was
| thinking of "mnt_uid" since simply using "uid=" would seem to overload
| the meaning of "uid", which is already used as a mount parm by various
| filesystems to signify the default uid for files ( ie in the cifs case
| when mounting to Windows - and Unix CIFS protocol extensions are not
| enabled) and it is not always the case that the default uid for files
| would be the same as the uid of the person who mounted.

For the last question, looks like "user=" is already used for that.
See 'man mount':

              user   Allow  an  ordinary  user to mount the file system.  The
                     name of the mounting user is written to mtab so that  he
                     can  unmount the file system again.  This option implies
                     the options noexec, nosuid, and nodev (unless overridden
                     by   subsequent   options,   as   in   the  option  line
                     user,exec,dev,suid).



--
~Randy
