Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbRBLOlR>; Mon, 12 Feb 2001 09:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129327AbRBLOlI>; Mon, 12 Feb 2001 09:41:08 -0500
Received: from mirasta.antefacto.net ([193.120.245.10]:47374 "EHLO
	mirasta.antefacto.net") by vger.kernel.org with ESMTP
	id <S129069AbRBLOk6>; Mon, 12 Feb 2001 09:40:58 -0500
From: Stephane Dudzinski <stephane@antefacto.com>
Reply-To: stephane@antefacto.com
To: linux-kernel@vger.kernel.org
Subject: Bug in i810 kernel module
Date: Mon, 12 Feb 2001 14:40:56 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: stephane@antefacto.com
MIME-Version: 1.0
Message-Id: <0102121440560G.00759@steph>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to submit the following bug to the list.

I've compiled the brand new 2.4.1 with the i810 module (the one which plays 
mp3s 15% faster than the usual speed). I did a hack modifying this line into :
/usr/src/linux/drivers/sound/i810_audio.c and modified the clocking as 
follows : 

static unsigned int clocking=41194;

I don't think this why i got this behavior but using xmms sucked 98% of the 
CPU time reading either mp3s or ogg files. Something is definitly wrong with 
this driver as ALSA ones work just fine (xmms then uses only 0.5% of the CPU 
time).

hope it is useful.
Cheers
Steph

-- 
Email sent with RH 7.0 running kernel 241
"Go away or I will replace you with a very small shell script" - ThinkGeek
Mailto:stephane@antefacto.com
Phone:8586009

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
