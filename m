Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVCAOHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVCAOHD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 09:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVCAOHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 09:07:02 -0500
Received: from zamok.crans.org ([138.231.136.6]:32675 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S261915AbVCAOGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 09:06:46 -0500
From: Mathieu Segaud <Mathieu.Segaud@crans.org>
To: Mathieu Segaud <Mathieu.Segaud@crans.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: 2.6.11-rc5-mm1
References: <20050301012741.1d791cd2.akpm@osdl.org>
	<871xazxyke.fsf@barad-dur.crans.org>
	<87wtsrwjms.fsf@barad-dur.crans.org>
Date: Tue, 01 Mar 2005 15:06:44 +0100
In-Reply-To: <87wtsrwjms.fsf@barad-dur.crans.org> (Mathieu Segaud's message of
	"Tue, 01 Mar 2005 15:00:59 +0100")
Message-ID: <87sm3fwjd7.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mathieu Segaud <Mathieu.Segaud@crans.org> disait derni=C3=A8rement que :

> Mathieu Segaud <Mathieu.Segaud@crans.org> disait derni=C3=A8rement que :
>
> Hum, one hunk didn't make it.
> The complete patch is attached

as any time I post with no sleep for 3 days, more noodles than brain
are in my skull. Did tha wrong strip level, didn't I ?

well, this the last one, with every hunk, and correct strip level


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=fix-reiser4-build.patch

--- linux/fs/reiser4/plugin/item/ctail.c	2005-03-01 14:57:52.756014040 +0100
+++ linux/fs/reiser4/plugin/item/ctail.c.new	2005-03-01 14:57:19.791025480 +0100
@@ -247,7 +247,7 @@
 reiser4_internal int
 check_ctail (const coord_t * coord, const char **error)
 {
-	if (!ctail_ok) {
+	if (!ctail_ok(coord)) {
 		if (error)
 			*error = "bad cluster shift in ctail";
 		return 1;
@@ -1666,7 +1666,7 @@
 		detach_convert_idata(pos->sq);
 		break;
 	case CRC_OVERWRITE_ITEM:
-		if (coord_is_unprepped_ctail) {
+		if (coord_is_unprepped_ctail(&pos->coord)) {
 			/* convert unpprepped ctail to prepped one */
 			int shift;
 			shift = inode_cluster_shift(item_convert_data(pos)->inode);

--=-=-=


Regards, time to go to bed

-- 
> >
> > Wait. Don't you mean:

Yes. Just ignore me when I show extreme signs of Alzheimers.

	- Linus Torvalds on linux-kernel

--=-=-=--
