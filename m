Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263073AbVHERC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263073AbVHERC4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 13:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbVHERC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 13:02:56 -0400
Received: from imap.gmx.net ([213.165.64.20]:10134 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263073AbVHERCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 13:02:30 -0400
X-Authenticated: #6553809
FCC: mailbox://creatix%40oco.net@pop.studcs.uni-sb.de/Sent
X-Identity-Key: id1
X-Account-Key: account1
Date: Fri, 5 Aug 2005 19:02:19 +0200
From: Thomas Heinz <thomasheinz@gmx.net>
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; uuencode=0
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: de, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: SCSI DVD-RAM partitions
References: <42CFC3EF.2090804@gmx.net> <20050712023757.GG26128@infradead.org> <42D37DF5.6060902@gmx.net> <20050731140157.GA6173@infradead.org>
In-Reply-To: <20050731140157.GA6173@infradead.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Length: 3121
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508051902.20165.thomasheinz@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

You wrote:
>>Ok, thanks for your valuable input. In fact, I thought about making
>>the device available both as /dev/srX and /dev/sdX at the same time
>>in order to support partitions. In my case it would even suffice to
>>make it available as /dev/sdX instead of /dev/srX.
> 
> That doesn't make sense because sd is a very different driver from sd.
> Besides that aliasing different dev_ts to the same underlying blockdevice
> can't work, it's cause all sorts of aliasing problems.

Ok.

> It would probably be better to use device-mapper than the loop device.
> I think there's already userland partition parsing code for dm, and
> having a simple command line tool to do that, and maybe even automatically
> run through udev and creating /dev/sr<num>p<partition> devices would
> be very nice to have as an almost invisible workaround.

Ok, that sounds reasonable. I have not yet searched for the partition
parsing code for dm but it should not be too hard to write this on
one's own. However, it is not clear to me whether this would work
automatically, i.e. insert dvd-ram medium -> udev event is triggered ->
device nodes are created via dmsetup.

Will there some (udev) event be triggered once a dvd-ram medium is
inserted?

Moreover, some event would have to be triggered if the dvd-ram medium
is removed in order to delete the device nodes.


Regards,

Thomas
