Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267264AbTBQQ7E>; Mon, 17 Feb 2003 11:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267267AbTBQQ7E>; Mon, 17 Feb 2003 11:59:04 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:53483 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S267264AbTBQQ7D>; Mon, 17 Feb 2003 11:59:03 -0500
Date: Mon, 17 Feb 2003 18:08:51 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 clings to you like flypaper
Message-ID: <20030217170851.GA18693@wohnheim.fh-wedel.de>
References: <78320000.1045465489@[10.10.2.4]> <1045482621.29000.40.camel@passion.cambridge.redhat.com> <2460000.1045500532@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2460000.1045500532@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 February 2003 08:48:55 -0800, Martin J. Bligh wrote:
> 
> The point remains, if I say I want ext2, I should get ext2, not whatever 
> some random developer decides he thinks I should have. Worst of all,
> the system then lies to you and says it's mounted ext2 when it's not.

This is, how things worked for me:
1. Kernel tries to mount rootfs ext3. If this fails, it will continue
trying ext2. No other fs compiled into kernel.
2. If there is a journal, it is ext3.
3. Init scripts read /etc/fstab and read ext2.
4. root is remounted as ext2.
5. System allows me to log it, root is ext2, life is good.

Where is your behaviour different from this list? Where do you say you
want ext2 but don't get it?

Jörn

-- 
Beware of bugs in the above code; I have only proved it correct, but
not tried it.
-- Donald Knuth
