Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266956AbRGMIF3>; Fri, 13 Jul 2001 04:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266959AbRGMIFT>; Fri, 13 Jul 2001 04:05:19 -0400
Received: from swsoft.mipt.ru ([193.125.143.146]:60406 "HELO srv.mipt.sw.ru")
	by vger.kernel.org with SMTP id <S266956AbRGMIFL>;
	Fri, 13 Jul 2001 04:05:11 -0400
Date: Fri, 13 Jul 2001 12:08:40 +0400
From: malfet@gw.mipt.sw.ru
To: linux-kernel@vger.kernel.org
Subject: Question about ext2
Message-ID: <20010713120840.A9431@srv.mipt.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!
I look up in implementation in ext2_rename and see the following statment:
       if (S_ISDIR(old_inode->i_mode)) {
                if (new_inode) {
                        retval = -ENOTEMPTY;
                        if (!empty_dir (new_inode))
                                goto end_rename;
                }
But I don't see any checkl like S_ISDIR on new_inode neither in ext2_rename neither in empty_dir. Is this bug? And, anyway, can I rename directory into not-empty file?
Thanks in advance,
	Nikita
P.S. Please, CC answer on malfet@mipt.sw.ru, because I'm not subscribed on this list
