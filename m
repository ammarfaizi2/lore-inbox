Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbVK2BQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbVK2BQl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 20:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVK2BQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 20:16:41 -0500
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:24274 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S932307AbVK2BQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 20:16:40 -0500
Message-ID: <438BB944.3060506@austin.rr.com>
Date: Mon, 28 Nov 2005 20:13:24 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: umount
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>>> drive is unplugged without unmounting, it you
> >>>> get a pop up dialog on screen telling you that data may be lost, etc.
> >>>> while under any of the main environments I've tried under Linux
> >>>> (Gnome, KDE, fluxbox) there are no such messages to the user. 

I get somewhat similar feedback from users who would like to see more informative 
user notification when other types of "removeable media" e.g a network mount
are temporarily or permanently unavailable.   An interesting example which can be
quite damaging is the case of password expiration when a user is mounted from
two systems ... if the session to the server ever drops from the other machine the reconnection
retries on machine one (with the bad password) silently cause the account to be locked on the server
if the user changed his password from the second machine.   There is no particularly good way to
tell the user "your password is expired or changed and I can't reconnect you to the server to 
write out this file until you tell me what the right password is" without some integration 
with the desktop.

Obviously MacOS, OS/2, Windows etc. had a head start on this kind of usability, but it would
be nice to talk with the KDE or Gnome people about what their needs are in this area - 
another example which comes up from time to time is that KDE and Gnome have no way on Linux
to detect or represent an "offline" file (ie a file which is on some HSM, such as a slow tape) 
that looks different from other files when browsing around in the standard file managers 
(this would be easy enough to do by query xattrs as XFS and JFS apparently stored information along
these lines in xattrs at one point).  These kinds of files show up with a different icon in 
other desktops and it is important for some types of users to be able to tell which files or directories
are "slow" to retrieve (offline).

