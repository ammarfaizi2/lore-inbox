Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbUFAO6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUFAO6e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 10:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUFAO6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 10:58:34 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:43431 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261913AbUFAO61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 10:58:27 -0400
Message-ID: <40BC997B.2070505@dsc-shop.de>
Date: Tue, 01 Jun 2004 16:58:03 +0200
From: Thomas Babut <tb@dsc-shop.de>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NFS: Problem with user and group IDs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: JO7BwOZUrecLZtXNhJnzO1qokZ+t9Ojx02ksbK9dY7Z3xYgzwT1J69@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got a problem with 'squashing' user and group IDs under NFS.

On the NFS Server there is the directory /data/test with owner ID 1011 
and group ID 100.

Here is the /etc/exports file on the NFS server:
/data/test 
172.16.10.1(ro,root_squash,all_squash,anon_uid=65534,anongid=65534)

On the client side I mount it with the command:
mount -t nfs 172.16.10.2:/data/test /mnt/test

After it has been successfully mounted, the directory on the client 
system has the owner ID 1011 and group ID 100, like on the server.

But the expected result for me is, that on the client system the 
directory has owner ID 65534 and group ID 65534 like it has been set in 
the /etc/exports file on the server.
I tried less options in the exports file as well. The result is always 
the same. With squash and without squash options.

Client and Server are Debian woody. I tried this on a Debian sid 
(unstable) system as well, same results. Switching from 
nfs-kernel-server to nfs-user-server didn't change anything, too.

My question is now: Is this a bug, or I am doing something wrong?

Thanks for any answer.

Regards,
Thomas Babut

