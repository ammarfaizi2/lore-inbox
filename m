Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSEUMFP>; Tue, 21 May 2002 08:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313120AbSEUMFO>; Tue, 21 May 2002 08:05:14 -0400
Received: from ulima.unil.ch ([130.223.144.143]:9957 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S313087AbSEUMFN>;
	Tue, 21 May 2002 08:05:13 -0400
Date: Tue, 21 May 2002 14:05:13 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: patch to compil sym53c416 under 2.5.x
Message-ID: <20020521120513.GA20389@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

since a few kernel, I try to compil without success, so as for 2.5.17
still with the same problem, here a quick fix:

--- sym53c416.c~	2002-01-31 18:07:05.000000000 +0100
+++ sym53c416.c	2002-05-21 11:00:08.000000000 +0200
@@ -449,7 +449,7 @@
 					sglist = current_command->request_buffer;
 					while(sgcount--)
 					{
-						tot_trans += sym53c416_write(base, sglist->address, sglist->length);
+						tot_trans += sym53c416_write(base, sglist->dma_address, sglist->length); 						sglist++;
 					}
 				}
@@ -475,7 +475,7 @@
 					sglist = current_command->request_buffer;
 					while(sgcount--)
 					{
-						tot_trans += sym53c416_read(base, sglist->address, sglist->length);
+						tot_trans += sym53c416_read(base, sglist->dma_address, sglist->length);
 						sglist++;
 					}
 				}

I use gcc 3.1 for compil.
I hope it's good to post to this list as I am not subscribed...

Thanks you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
