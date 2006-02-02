Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423422AbWBBJqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423422AbWBBJqj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 04:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161076AbWBBJqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 04:46:39 -0500
Received: from relay1.wplus.net ([195.131.52.143]:5642 "EHLO relay1.wplus.net")
	by vger.kernel.org with ESMTP id S1161018AbWBBJqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 04:46:38 -0500
From: Vitaly Fertman <vitaly@namesys.com>
Reply-To: vitaly@namesys.com
To: reiserfs-dev@namesys.com
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
Date: Thu, 2 Feb 2006 12:42:21 +0300
User-Agent: KMail/1.7.1
Cc: Denis Vlasenko <vda@ilport.com.ua>, Chris Mason <mason@suse.com>,
       Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
References: <200601281613.16199.vda@ilport.com.ua> <200601300822.47821.mason@suse.com> <200602020925.00863.vda@ilport.com.ua>
In-Reply-To: <200602020925.00863.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602021242.21512.vitaly@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > reiserfstune -s 1024 /dev/xxxx
> 
> I had reiserfsprogs 3.6.11 and reiserfstune (above command) made my /dev/sdc3
> unmountable without -t reiserfs. I upgraded reiserfsprogs to 3.6.19 and now
> reiserfsck /dev/sdc3 reports no problems, but mount problem persists:
> 
> # mount -t reiserfs /dev/sdc3 /.3
> # umount /.3
> # mount /dev/sdc3 /.3
> mount: you must specify the filesystem type
> # dmesg | tail -3
> br: port 1(ifi) entering forwarding state
> FAT: bogus number of reserved sectors
> VFS: Can't find a valid FAT filesystem on dev sdc3.
> 
> "chown -Rc <n>:<m> ." now does not OOM kill the box, so this issue
> is resolved, thanks!
> 
> Can I restore sdc3 somehow that I won't need -t reiserfs in mount command?
> You can find result of
> 
> dd if=/dev/sdc3 of=1m bs=1M count=1
> 
> at http://195.66.192.167/linux/1m

the problem seems to be in mount program, which version do you use?
I still have no problem with your 1m image, mount version is 2.11z, 
2.12c.

-- 
Vitaly
