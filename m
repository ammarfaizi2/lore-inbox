Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263721AbUCXOP3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 09:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbUCXOP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 09:15:29 -0500
Received: from gamemakers.de ([217.160.141.117]:61912 "EHLO www.gamemakers.de")
	by vger.kernel.org with ESMTP id S263721AbUCXOP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 09:15:28 -0500
Message-ID: <4061986E.6020208@gamemakers.de>
Date: Wed, 24 Mar 2004 15:17:18 +0100
From: =?ISO-8859-1?Q?R=FCdiger_Klaehn?= <rudi@gamemakers.de>
Reply-To: rudi@lambda-computing.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: ttb@tentacle.dhs.org, jamie@shareable.org, tridge@samba.org,
       viro@parcelfarce.linux.theplanet.co.uk, torvalds@osdl.org,
       alexl@redhat.com
Subject: [RFC,PATCH] dnotify: enhance or replace?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have been working on a dnotify enhancement to let it work recursively 
and to store information about what exactly has changed.

My current code can be found here:
<http://www.lambda-computing.com/~rudi/dnotify/>

 From reading the list, I got the impression that there is a general 
consensus that the current dnotify mechanism is less than optimal, and 
that something should be done about it. Is that correct?

My current implementation enhances the dnotify mechanism, but is 
backwards compatible to the old mechanism. This is obviously the least 
intrusive approach, but it is also less than optimal. For example it 
still requires an open file handle to watch for changes in a tree, so it 
will create problems when unmounting a device.

In an offline discussion, the issue came up wether it would not be 
better to replace dnotify with a completely new mechanism like e.g. a 
special netlink socket. Since most userspace programs (e.g. KDE and 
gnome) do not use dnotify directly, but through the fam daemon, the 
required changes in user space applications would not be that great.

So what is your take on this? Enhance or replace?

best regards,

Rüdiger

p.s.: I cc'ed everybody who I think might be interested in a dnotify 
enhancement/replacement.
