Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317482AbSHYTKX>; Sun, 25 Aug 2002 15:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317488AbSHYTKX>; Sun, 25 Aug 2002 15:10:23 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:35815 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S317482AbSHYTKX>; Sun, 25 Aug 2002 15:10:23 -0400
Date: Sun, 25 Aug 2002 15:18:54 -0400
To: ehw@lanl.gov, dledford@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.31 qlogic error "this should not happen"
Message-ID: <20020825191854.GA32490@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I occasionally saw that error on our 2.4 RAID system; it went away when I
> increased the size of the handles array in qlogicfc.h:

-#define QLOGICFC_REQ_QUEUE_LEN  127 /* must be power of two - 1 */
+#define QLOGICFC_REQ_QUEUE_LEN  255 /* must be power of two - 1 */

That change in addition to Doug's patch in 
http://marc.theaimsgroup.com/?l=linux-kernel&m=103005703808312&w=2
have done the trick. 2.5.31-mm1-dl-ew completed the 54 hour
benchmarathon. (first 2.5 kernel to finish). 

Details at:
http://home.earthlink.net/~rwhron/kernel/bigbox.html
-- 
Randy Hron

