Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278945AbRJ2B6v>; Sun, 28 Oct 2001 20:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278950AbRJ2B6l>; Sun, 28 Oct 2001 20:58:41 -0500
Received: from [63.231.122.81] ([63.231.122.81]:19515 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S278945AbRJ2B63>;
	Sun, 28 Oct 2001 20:58:29 -0500
Date: Sun, 28 Oct 2001 18:58:44 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "David S. Miller" <davem@redhat.com>
Cc: jgarzik@mandrakesoft.com, miles@megapathdsl.net, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: What is standing in the way of opening the 2.5 tree?
Message-ID: <20011028185844.C1311@lynx.no>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	jgarzik@mandrakesoft.com, miles@megapathdsl.net,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <1004219488.11749.19.camel@stomata.megapathdsl.net> <3BDB91D7.C7975C44@mandrakesoft.com> <20011027.224602.74750641.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011027.224602.74750641.davem@redhat.com>; from davem@redhat.com on Sat, Oct 27, 2001 at 10:46:02PM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 27, 2001  22:46 -0700, David S. Miller wrote:
> In particular, the quota stuff, which has sat in Alan's tree forever.
> If Linus is ignoring the changes it probably is for a good reason
> but it would be nice for him to let Alan know what that reason is :-)

AFAIK (not much, since I don't use quotas), the on-disk quota format used
by Alan's tree was changed to support 32-bit UID/GIDs, which makes it
incompatible with that used in the Linus tree.  However, there was also
some quota merging done in 2.4.13 or so, which _may_ have resolved this.

Yes, it's vague, but nobody else has answered yet.  I'm only aware of these
issues because the ext3 code had to work with both trees, and the quota
compat stuff was removed in the most recent ext3 release.  That may have
only been an in-kernel API issue and not the on-disk format, I don't know.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

