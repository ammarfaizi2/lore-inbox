Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266464AbRG1HJE>; Sat, 28 Jul 2001 03:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266469AbRG1HIy>; Sat, 28 Jul 2001 03:08:54 -0400
Received: from 205-158-62-68.outblaze.com ([205.158.62.68]:64700 "HELO
	ws2-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S266464AbRG1HIp>; Sat, 28 Jul 2001 03:08:45 -0400
Message-ID: <20010728070847.3705.qmail@juno.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Frank Davis" <fdavis112@juno.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Date: Sat, 28 Jul 2001 15:08:46 +0800
Subject: Re: [PATCH] 2.4.7-ac2 :fs/jffs2/background.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello all,
   The patch I sent regarding fs/jffs2/background.c compiled, however, further testing of the patch made me realize that complete_and_exit requires a struct completion, not struct semaphore. I added a struct completion gc_thread_sem_comp to jffs2_sb_info and added #include &lt;linux/completion.h&gt; to include/linux/jffs2_fs_sb.h ...When I re-ran 'make modules' , drivers/ieee1394/ieee1394_core.o didn't compile....a &quot;completion reference error&quot; occurred. Without the change to jffs2_fs_sb.h , ieee1394 and jffs2 compiled. Are there dependencies between ieee1394 and jffs2 ? I wouldn't believe that there would. 
Regards,
Frank

-- 


