Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267178AbSKSSq7>; Tue, 19 Nov 2002 13:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267190AbSKSSqW>; Tue, 19 Nov 2002 13:46:22 -0500
Received: from air-2.osdl.org ([65.172.181.6]:16768 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S267178AbSKSSpf>;
	Tue, 19 Nov 2002 13:45:35 -0500
Date: Tue, 19 Nov 2002 10:52:36 -0800
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.48] Fixed ifdefs for a label in ncpfs/sock.c
Message-ID: <20021119185236.GI1986@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/fs/ncpfs/sock.c b/fs/ncpfs/sock.c
--- a/fs/ncpfs/sock.c	Tue Nov 19 10:31:17 2002
+++ b/fs/ncpfs/sock.c	Tue Nov 19 10:31:17 2002
@@ -587,7 +587,9 @@
 				}
 #endif				
 				type = ntohs(server->rcv.buf.type);
+#ifdef CONFIG_NCPFS_PACKET_SIGNING				
 cont:;				
+#endif
 				if (type != NCP_REPLY) {
 					if (datalen - 8 <= sizeof(server->unexpected_packet.data)) {
 						*(__u16*)(server->unexpected_packet.data) = htons(type);

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
