Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbRBUWl6>; Wed, 21 Feb 2001 17:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbRBUWls>; Wed, 21 Feb 2001 17:41:48 -0500
Received: from dns-229.dhcp-248.nai.com ([161.69.248.229]:243 "HELO
	localdomain") by vger.kernel.org with SMTP id <S129181AbRBUWld>;
	Wed, 21 Feb 2001 17:41:33 -0500
Message-ID: <XFMail.20010221144316.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010221232635.A25272@atrey.karlin.mff.cuni.cz>
Date: Wed, 21 Feb 2001 14:43:16 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
To: Martin Mares <mj@suse.cz>
Subject: Re: [rfc] Near-constant time directory index for Ext2
Cc: Linux-kernel@vger.kernel.org, tytso@valinux.com,
        Andreas Dilger <adilger@turbolinux.com>, hch@ns.caldera.de,
        ext2-devel@lists.sourceforge.net,
        Daniel Phillips <phillips@innominate.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 21-Feb-2001 Martin Mares wrote:
> Hello!
> 
>> My personal preference goes to skiplist coz it doesn't have fixed ( or
>> growing
>> ) tables to handle. You've simply a stub of data togheter with FS data in
>> each
>> direntry.
> 
> Another problem with skip lists is that they require variable sized nodes,
> so you either need to keep free chunk lists and lose some space in deleted
> nodes kept in these lists, or you choose to shift remaining nodes which is
> slow and complicated as you need to keep the inter-node links right. With
> hashing, you can separate the control part of the structure and the actual
> data and shift data while leaving most of the control part intact.

An entry in skip list table is a u32 direntry offset and You've not to keep
free entries, simply the height of the node will change depending on the number
of entries.


>> And performance ( O(log2(n)) ) are the same for whatever number of entries.
> 
> I don't understand this complexity estimate -- it cannot be the same for
> whatever number of entries as the complexity function depends on the number
> of entries.

n == number of entries

For constant I mean the formula not the result.



- Davide

