Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129281AbRBURTl>; Wed, 21 Feb 2001 12:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129454AbRBURTc>; Wed, 21 Feb 2001 12:19:32 -0500
Received: from dns-229.dhcp-248.nai.com ([161.69.248.229]:5272 "HELO
	localdomain") by vger.kernel.org with SMTP id <S129281AbRBURT1>;
	Wed, 21 Feb 2001 12:19:27 -0500
Message-ID: <XFMail.20010221092103.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <01022020011905.18944@gimli>
Date: Wed, 21 Feb 2001 09:21:03 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
To: Daniel Phillips <phillips@innominate.de>
Subject: RE: [rfc] Near-constant time directory index for Ext2
Cc: ext2-devel@lists.sourceforge.net, hch@ns.caldera.de,
        Andreas Dilger <adilger@turbolinux.com>, tytso@valinux.com,
        Linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20-Feb-2001 Daniel Phillips wrote:
> Earlier this month a runaway installation script decided to mail all its
> problems to root.  After a couple of hours the script aborted, having
> created 65535 entries in Postfix's maildrop directory.  Removing those
> files took an awfully long time.  The problem is that Ext2 does each
> directory access using a simple, linear search though the entire
> directory file, resulting in n**2 behaviour to create/delete n files. 
> It's about time we fixed that.
> 
> Last fall in Miami, Ted Ts'o mentioned some ideas he was playing with
> for an Ext2 directory index, including the following points:
> 
>   - Fixed-size hash keys instead of names in the index
>   - Leaf blocks are normal ext2 directory blocks
>   - Leaf blocks are sequental, so readdir doesn't have to be changed

Have You tried to use skiplists ?
In 93 I've coded a skiplist based directory access for Minix and it gave very
interesting performances.
Skiplists have a link-list like performance when linear scanned, and overall
good performance in insertion/seek/delete.




- Davide

