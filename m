Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129379AbRBUV60>; Wed, 21 Feb 2001 16:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129686AbRBUV6Q>; Wed, 21 Feb 2001 16:58:16 -0500
Received: from dns-229.dhcp-248.nai.com ([161.69.248.229]:23500 "HELO
	localdomain") by vger.kernel.org with SMTP id <S129379AbRBUV6E>;
	Wed, 21 Feb 2001 16:58:04 -0500
Message-ID: <XFMail.20010221135903.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010221223238.A17903@atrey.karlin.mff.cuni.cz>
Date: Wed, 21 Feb 2001 13:59:03 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
To: Martin Mares <mj@suse.cz>
Subject: Re: [rfc] Near-constant time directory index for Ext2
Cc: Daniel Phillips <phillips@innominate.de>, ext2-devel@lists.sourceforge.net,
        hch@ns.caldera.de, Andreas Dilger <adilger@turbolinux.com>,
        tytso@valinux.com, Linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 21-Feb-2001 Martin Mares wrote:
> Hello!
> 
>> To have O(1) you've to have the number of hash entries > number of files and
>> a
>> really good hasing function.
> 
> No, if you enlarge the hash table twice (and re-hash everything) every time
> the
> table fills up, the load factor of the table keeps small and everything is
> O(1)
> amortized, of course if you have a good hashing function. If you are really
> smart and re-hash incrementally, you can get O(1) worst case complexity, but
> the multiplicative constant is large.

My personal preference goes to skiplist coz it doesn't have fixed ( or growing
) tables to handle. You've simply a stub of data togheter with FS data in each
direntry.
And performance ( O(log2(n)) ) are the same for whatever number of entries.




- Davide

