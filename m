Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUCDBss (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 20:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbUCDBss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 20:48:48 -0500
Received: from twinlark.arctic.org ([168.75.98.6]:38549 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S261347AbUCDBsr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 20:48:47 -0500
Date: Wed, 3 Mar 2004 17:48:46 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
cc: James Morris <jmorris@redhat.com>, Christophe Saout <christophe@saout.de>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: dm-crypt, new IV and standards
In-Reply-To: <20040303150647.GC1586@certainkey.com>
Message-ID: <Pine.LNX.4.58.0403031735210.26196@twinlark.arctic.org>
References: <20040220172237.GA9918@certainkey.com>
 <Xine.LNX.4.44.0402201624030.7335-100000@thoron.boston.redhat.com>
 <20040221164821.GA14723@certainkey.com> <Pine.LNX.4.58.0403022352080.12846@twinlark.arctic.org>
 <20040303150647.GC1586@certainkey.com>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2004, Jean-Luc Cooke wrote:

> The difference between "$1,000,000" and "$8,000,000" is 1 bit.  If an
> attacker knew enough about the layout of the filesystem (modify times on blocks,
> etc) they could flip a single bit and change your $1Mil purchase order
> approved by your boss to a $8Mil order.

ah ok i was completely ignoring the desire to prevent data tampering.

you have to admit it's still a bit more effort than flipping 1 bit like
you suggest since you need to tweak the encrypted data enough so that the
decrypted data has only 1 bit flipped.  (especially if you use CBC like
you mention.)

something else which i've been wondering about -- would there be any extra
protection provided by permuting block addresses so that the location of
wellknown blocks such as the superblock and inode maps aren't so
immediately obvious?  given the lack of known plaintext attacks on AES i'm
thinking there's no point to permuting, but i'm not a cryptographer, i
only know enough to be dangerous.  (you'd want to choose a permutation
which makes some effort to group blocks into large enough chunks so that
*some* seek locality can be maintained.)

-dean
