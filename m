Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261485AbTCQJhv>; Mon, 17 Mar 2003 04:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261533AbTCQJhv>; Mon, 17 Mar 2003 04:37:51 -0500
Received: from holomorphy.com ([66.224.33.161]:32729 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261485AbTCQJhu>;
	Mon, 17 Mar 2003 04:37:50 -0500
Date: Mon, 17 Mar 2003 01:48:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alex Tomas <bzzz@tmi.comex.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] distributed counters for ext2 to avoid group scaning
Message-ID: <20030317094823.GQ20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alex Tomas <bzzz@tmi.comex.ru>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
References: <m3el5773to.fsf@lexa.home.net> <20030317093712.GP20188@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030317093712.GP20188@holomorphy.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 16, 2003 at 06:01:55PM +0300, Alex Tomas wrote:
>> ext2 with concurrent balloc/ialloc doesn't maintain global free
>> inodes/blocks counters. this is due to badness of spinlocks and
>> atomic_t from big iron's viewpoint. therefore, to know these values
>> we should scan all group descriptors.  there are 81 groups for 10G
>> fs. I believe there is method to avoid scaning and decrease memory
>> footprint. 

On Mon, Mar 17, 2003 at 01:37:12AM -0800, William Lee Irwin III wrote:
> benching now

Bad news. I don't have big enough fs's to do this one. Working it...

$ df -HT
Filesystem    Type     Size   Used  Avail Use% Mounted on
/dev/sda2     ext2     4.2G   2.8G   1.2G  72% /
/dev/sdb1     ext2     9.1G   7.0G   1.6G  82% /home
/dev/sdb2     ext2     9.1G    42M   8.6G   1% /results
/dev/sdd1     ext2      19G   8.0G   9.2G  47% /work
/dev/sde1     ext2      19G   1.7G    16G  10% /test
$ 

-- wli
