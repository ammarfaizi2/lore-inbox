Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLTGaq>; Wed, 20 Dec 2000 01:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLTGag>; Wed, 20 Dec 2000 01:30:36 -0500
Received: from smtp.mountain.net ([198.77.1.35]:29188 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S129183AbQLTGaU>;
	Wed, 20 Dec 2000 01:30:20 -0500
Message-ID: <3A404ACF.DADFE90D@mountain.net>
Date: Wed, 20 Dec 2000 00:59:43 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: laforge@gnumonks.org, rusty@linuxcare.com.au, kuznet@ms2.inr.ac.ru,
        netfilter-devel@us5.samba.org, linux-kernel@vger.kernel.org
Subject: Re: ip_defrag / ip_conntrack issues (was Re: [PATCH] Fix netfilter 
 locking)
In-Reply-To: <E147qmG-0001yB-00@halfway> <200012181811.KAA05490@pizda.ninka.net> <20001218201402.Y7422@coruscant.gnumonks.org> <3A3F68D7.A167E01@mountain.net> <200012191412.GAA06310@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> This is basically what is in my tree right now.  However, there was
> one reporter who claimed that after this kind of change he still was
> able to lockup/OOPS his machine by logging into X as a user who had
> his home directory over NFS.  This was with netfilter enabled as well
> so it has to be the same bug.
> 
> Later,
> David S. Miller
> davem@redhat.com

2.4.0-test12+ip_fragment.c.patch is still up. I hadn't previously tried
client-side mounts on that box, just exports.

I tried to reproduce the problem with nfs home directory mount + X. I am
unable to generate the error -- it works for me. I think Alexey is right.
There may be either coincidence or confusion in the report.

Btw, I am able to compile a kernel over an nfs mount with this. Very handy
since the remote is much faster at it.

Cheers,
Tom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
