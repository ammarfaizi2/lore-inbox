Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261789AbTCQRRB>; Mon, 17 Mar 2003 12:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261801AbTCQRRB>; Mon, 17 Mar 2003 12:17:01 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:63057 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S261789AbTCQRQ7>;
	Mon, 17 Mar 2003 12:16:59 -0500
Message-ID: <3E760598.6040604@mvista.com>
Date: Mon, 17 Mar 2003 11:27:52 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Louis Zhuang <louis.zhuang@linux.co.intel.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] socket interface for IPMI
References: <1047462010.1051.14.camel@hawk.sh.intel.com>	 <3E6F6963.6020100@mvista.com> <1047526187.1051.30.camel@hawk.sh.intel.com>
In-Reply-To: <1047526187.1051.30.camel@hawk.sh.intel.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'd prefer a list of valid users, with root always allowed.  I don't 
know how easy this is with a sysctl, but it shouldn't be too bad, I 
would think.

- -Corey

Louis Zhuang wrote:

|Hmmm, security is a big problem. I can not find an elegant way to do ACL
|because these is no "inode" in sockfs... But how about making only root
|be able to open IPMI socket like PACKET socket? Or else we can implement
|a sysctl to indicate the legal user of the IPMI socket.
|
|Any comments?
|
|  - Louis
|On Thu, 2003-03-13 at 01:07, Corey Minyard wrote:
|
|>I agree, and I've thought hard about this in the past.  The code looks
|>clean, and the design is straightforward.  However, I have not figured
|>out how to handle security.  In your implementation, anyone can open an
|>IPMI socket, which is a bad thing.  I like that fact that administrators
|>can set the permissions on the device any way they like (so it can
|>belong to root, a maintenance user, ACLs can be used, etc.)
|>
|>Any thoughts on that?  Once that problem is solved, I would like to
|>include this.
|>
|>- -Corey
|>
|>Louis Zhuang wrote:
|>
|>|Dear Corey,
|>|    I'd like to propose a socket interface for IPMI. IMHO, IPMI is like a
|>|mini-network so it is natural to manipulate IPMI by socket. Following
|>|code demostrate the interface's usage.
|>|P.S. the patch is a quick and dirty implementation with full of holes,
|>|I'll refine it if you like to adopt it, so do not blame me at this time
|>|;-).
|>|
|
|
|
|

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+dgWXmUvlb4BhfF4RApBsAJ9AS4aAskvQLDNtYhW5PzjGUtZ/jgCfSDvF
d5Op76MZgz5Kgg8kHHiJWCU=
=MSck
-----END PGP SIGNATURE-----


