Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317102AbSHGIiK>; Wed, 7 Aug 2002 04:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317107AbSHGIiK>; Wed, 7 Aug 2002 04:38:10 -0400
Received: from 205-158-62-111.outblaze.com ([205.158.62.111]:4881 "HELO
	ws1-10.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S317102AbSHGIiJ>; Wed, 7 Aug 2002 04:38:09 -0400
Message-ID: <20020807084133.17787.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Ana Yuseepi" <anayuseepi@asia.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 07 Aug 2002 03:41:33 -0500
Subject: lost interrupt and inb()
X-Originating-Ip: 210.159.65.4
X-Originating-Server: ws1-10.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello all,
 
i tried to made a program in the form of a module. This program would attempt to read/poll status register of IDE until the value for the status register is 0x50. 
 
here is the algorithm:
 
 save_flag();
 disable_interrupt();
 poll_or_read_or_get_input_from_IDE_status_register();
 enable_interrupt();
 restore_flags();
 
 this program would run fine, but after the program is finished executing, it would display a message:
 ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
 hdc: lost interrupt
 
the OS doesn't hang. because normal operation would resume after this program exit.
 OS=linux 7.3, kernel=2.4.18-3
 
my question is:
how can i solve this error such that the error message would not appear anymore?
 
i have lots of other questions, but that of the above is the most important..
 
hope to hear your reply,
 
-Ana
-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Get 4 DVDs for $.49 cents! plus shipping & processing. Click to join. 
http://adfarm.mediaplex.com/ad/ck/990-1736-3566-59

