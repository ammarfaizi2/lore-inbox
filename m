Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276468AbRJDJwl>; Thu, 4 Oct 2001 05:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276480AbRJDJwb>; Thu, 4 Oct 2001 05:52:31 -0400
Received: from smtp2.cluster.oleane.net ([195.25.12.17]:33806 "EHLO
	smtp2.cluster.oleane.net") by vger.kernel.org with ESMTP
	id <S276468AbRJDJwR>; Thu, 4 Oct 2001 05:52:17 -0400
Date: Thu, 4 Oct 2001 11:52:36 +0200
From: Nicolas Mailhot <Nicolas.Mailhot@one2team.com>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] Symlinks broken on 2.4.10-ac[3-4] nfs
Message-ID: <20011004115236.A9373@ulysse.olympe.o2t>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I've found out much to my sorrow that the latest
ac's do not handle symlinks over nfs well.
For example, I get that kind of results :

lrwxrwxrwx    1 nim      cvs            92 oct  4 11:47
release.xml -> ../antbui
ld/init/release.xml?Q�*U!�M~?W�?0>�%�?���?���]��v�??�?�JO#b�?��G�\?�1�?��B?�;??
�HT
lrwxrwxrwx    1 nim      cvs           387 oct  4 11:47 xml
-> ../antbuild/init/
xml���?��w?z�$�E��%J�4�<?B��Y`L?�>=1��>�?�???���?�����??��?�q]?4�G??�?�??�:�J]��
�?7���xx�Z&?z��{??^�9L�?|m?ש]?4?�i��?NL�[#?|���cHh;�?r�?$�E�I$�F?y???y��?�??W9
m?1<FA?v*@KG�?ܰ�d�l8?�?�F�,��&�l�ݬ��S?Z�?�M?iUi�b??c��x.?���j?�g?�f.f!�?�p�G��
�??�Q�AbwV1�2��1�L?QK�??�?@��a��?�?��??�??,�?u)�uR�&T��

after a 
[nim@ulysse ant]$ln -s ../antbuild/init/*xml .
[nim@ulysse ant]$ls -l

This is over an nfs mounted directory, server and client
2.4.40-ac4 nfs3, server-side fs : ext2

That's pretty ugly isn't it ?

-- 
Nicolas Mailhot
