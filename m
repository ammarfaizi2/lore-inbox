Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262118AbTCMDT1>; Wed, 12 Mar 2003 22:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262120AbTCMDT1>; Wed, 12 Mar 2003 22:19:27 -0500
Received: from fmr02.intel.com ([192.55.52.25]:64749 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S262118AbTCMDT0>; Wed, 12 Mar 2003 22:19:26 -0500
Subject: Re: [RFC][PATCH] socket interface for IPMI
From: Louis Zhuang <louis.zhuang@linux.co.intel.com>
To: Corey Minyard <cminyard@mvista.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3E6F6963.6020100@mvista.com>
References: <1047462010.1051.14.camel@hawk.sh.intel.com>
	 <3E6F6963.6020100@mvista.com>
Content-Type: text/plain
Organization: Intel Crop.
Message-Id: <1047526187.1051.30.camel@hawk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 13 Mar 2003 11:29:47 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm, security is a big problem. I can not find an elegant way to do ACL
because these is no "inode" in sockfs... But how about making only root
be able to open IPMI socket like PACKET socket? Or else we can implement
a sysctl to indicate the legal user of the IPMI socket. 

Any comments?

  - Louis
On Thu, 2003-03-13 at 01:07, Corey Minyard wrote:
> I agree, and I've thought hard about this in the past.  The code looks 
> clean, and the design is straightforward.  However, I have not figured 
> out how to handle security.  In your implementation, anyone can open an 
> IPMI socket, which is a bad thing.  I like that fact that administrators 
> can set the permissions on the device any way they like (so it can 
> belong to root, a maintenance user, ACLs can be used, etc.)
> 
> Any thoughts on that?  Once that problem is solved, I would like to 
> include this.
> 
> - -Corey
> 
> Louis Zhuang wrote:
> 
> |Dear Corey,
> |    I'd like to propose a socket interface for IPMI. IMHO, IPMI is like a
> |mini-network so it is natural to manipulate IPMI by socket. Following
> |code demostrate the interface's usage.
> |P.S. the patch is a quick and dirty implementation with full of holes,
> |I'll refine it if you like to adopt it, so do not blame me at this time
> |;-).
> |


