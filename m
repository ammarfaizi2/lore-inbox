Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285051AbRLQHGc>; Mon, 17 Dec 2001 02:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285049AbRLQHGW>; Mon, 17 Dec 2001 02:06:22 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:13700 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S285036AbRLQHGP>; Mon, 17 Dec 2001 02:06:15 -0500
Date: Mon, 17 Dec 2001 09:05:46 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Ia64 unaligned accesses in ntfs driver
Message-ID: <20011217090545.N12063@niksula.cs.hut.fi>
In-Reply-To: <20011216124328.E21566@niksula.cs.hut.fi> <20011216191325.K12063@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011216191325.K12063@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Sun, Dec 16, 2001 at 07:13:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get unaligned accesses from these addresses:

kernel unaligned access to 0xe00000006fb49719, ip=0xa000000000265050

from ksymoops:
Adhoc a000000000265050 <[ntfs]ntfs_decompress+d0/320>
Adhoc a000000000262d80 <[ntfs]ntfs_decompress_run+2a0/3c0>
Adhoc a000000000262ba0 <[ntfs]ntfs_decompress_run+c0/3c0>
Adhoc a000000000262d60 <[ntfs]ntfs_decompress_run+280/3c0>

Are these dangerous? I gather IA64 port has some kind of handler for these,
since they don't oops.


-- v --

v@iki.fi
