Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290277AbSBXRdP>; Sun, 24 Feb 2002 12:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290289AbSBXRdF>; Sun, 24 Feb 2002 12:33:05 -0500
Received: from ws-han1.win-ip.dfn.de ([193.174.75.150]:43261 "EHLO
	ws-han1.win-ip.dfn.de") by vger.kernel.org with ESMTP
	id <S290277AbSBXRcw>; Sun, 24 Feb 2002 12:32:52 -0500
Date: Sun, 24 Feb 2002 18:34:59 +0100
Message-ID: <vines.sxdD+0FGSwA@SZKOM.BFS.DE>
X-Priority: 3 (Normal)
To: <linux-kernel@vger.kernel.org>
From: <WHarms@bfs.de> (Walter Harms)
Reply-To: <WHarms@bfs.de>
Subject: fix: lp.c wrong return code
X-Incognito-SN: 25185
X-Incognito-Version: 5.1.0.84
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="1014572039-MIME-Part-Dividor"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1014572039-MIME-Part-Dividor
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,
how takes care about the lp driver ? i saw some changes in the 2.4 but found no maintainer.
to the maintainer:
LPGETSTATS is strange. first you set LP_STAT then you delete it. maybe a EACCES (Permission denied) would do it ?



problem:
calling the ioctl( LPSETIRQ ) the driver returns EINVAL (Invalid argument)instead of ENOSYS.

Fix : return ENOSYS (Function not implemented)

NOTE:
if EINVAL is correct, you can delete the entiere entry, EINVAL in default.



--1014572039-MIME-Part-Dividor
Content-type: application/octet-stream;
              name="lp.diff"
Content-Disposition: attachment; filename="lp.diff"
Content-Transfer-Encoding: base64

LS0tIGxwLmMub2xkCVN1biBGZWIgMjQgMTg6MTk6NTkgMjAwMgorKysgbHAuYwlTdW4gRmViIDI0
IDE4OjIwOjU3IDIwMDIKQEAgLTgwNiw3ICs4MDYsNyBAQAogCQkJTFBfV0FJVChtaW5vcikgPSBh
cmc7CiAJCQlicmVhazsKIAkJY2FzZSBMUFNFVElSUTogCi0JCQlyZXR1cm4gLUVJTlZBTDsKKwkJ
CXJldHVybiAtRU5PU1lTOwogCQkJYnJlYWs7CiAJCWNhc2UgTFBHRVRJUlE6CiAJCQlpZiAoY29w
eV90b191c2VyKChpbnQgKikgYXJnLCAmTFBfSVJRKG1pbm9yKSwK

--1014572039-MIME-Part-Dividor--
