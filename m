Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264891AbSJVVe1>; Tue, 22 Oct 2002 17:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264872AbSJVVe1>; Tue, 22 Oct 2002 17:34:27 -0400
Received: from msp-65-29-16-62.mn.rr.com ([65.29.16.62]:60806 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S264891AbSJVVe0>; Tue, 22 Oct 2002 17:34:26 -0400
Date: Tue, 22 Oct 2002 16:39:28 -0500
From: Shawn <core@enodev.com>
To: Harald Welte <laforge@gnumonks.org>
Cc: Joern Nettingsmeier <nettings@folkwang-hochschule.de>,
       linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: trivial netfilter compile problem in 2.5.4[34]-mm2
Message-ID: <20021022163928.A31552@q.mn.rr.com>
References: <3DB46781.D4245373@folkwang-hochschule.de> <20021022150414.GN3039@naboo.club.berlin.ccc.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021022150414.GN3039@naboo.club.berlin.ccc.de>; from laforge@gnumonks.org on Tue, Oct 22, 2002 at 05:04:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Patch already in LK, but here goes:


On 10/22, Harald Welte said something like:
> On Mon, Oct 21, 2002 at 10:45:53PM +0200, Joern Nettingsmeier wrote:
> > hi *!
> > 
> > 
> > in order to compile 2.5.4[34], i had to add #include
> > <linux/netfilter_ipv4> to net/ipv4/raw.c, since it choked on
> > NF_IP_LOCAL_OUT being undefined in line 297.
> > 
> > since i've had this problem for two kernel releases now, i thought i'd
> > bring this to your attention.
> 
> Thanks a lot, I will investigate this once I am close to an internet
> connection and can download the respective kernel version(s).
> 
> > regards,
> > jörn
> 
> -- 
> Live long and prosper
> - Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
> ============================================================================
> GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
> V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
Shawn Leas
core@enodev.com

While I was gone, somebody rearranged on the furniture in my
bedroom.  They put it in _exactly_ the same place it was.
When I told my roommate, he said: Do I know you?
						-- Stephen Wright

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="raw.diff"

--- raw.old	Tue Oct 22 16:38:30 2002
+++ raw.c	Tue Oct 22 16:38:15 2002
@@ -64,7 +64,7 @@
 #include <net/raw.h>
 #include <net/inet_common.h>
 #include <net/checksum.h>
-#include <linux/netfilter.h>
+#include <linux/netfilter_ipv4.h>
 
 struct sock *raw_v4_htable[RAWV4_HTABLE_SIZE];
 rwlock_t raw_v4_lock = RW_LOCK_UNLOCKED;

--ew6BAiZeqk4r7MaW--
