Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267895AbUGaCFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267895AbUGaCFP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 22:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267897AbUGaCFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 22:05:14 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:34807 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S267895AbUGaCFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 22:05:06 -0400
Subject: uid of user who mounts
From: Steve French <smfrench@austin.rr.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1091239509.3894.11.camel@smfhome.smfdom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 30 Jul 2004 21:05:09 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To allow user unmounts of cifs shares (much like the setuid smbumount
utility allows for smbfs), it has been suggested that the cifs vfs could
return the uid of the mounter in /proc/mounts  This would avoid having
to add an ioctl (as smbfs did) and seems as secure as the ioctl approach
(to get the uid of the original mounter).

If user mounts are allowed, is there any worse security exposure in
letting the tool check the uid who mounted via /proc/mounts (to allow
user unmount).   

Is there any precedent for the name for the name of such a parm?  I was
thinking of "mnt_uid" since simply using "uid=" would seem to overload
the meaning of "uid", which is already used as a mount parm by various
filesystems to signify the default uid for files ( ie in the cifs case
when mounting to Windows - and Unix CIFS protocol extensions are not
enabled) and it is not always the case that the default uid for files
would be the same as the uid of the person who mounted.


