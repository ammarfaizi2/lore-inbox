Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265985AbRF1Ozi>; Thu, 28 Jun 2001 10:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265984AbRF1Oz2>; Thu, 28 Jun 2001 10:55:28 -0400
Received: from spc.esa.lanl.gov ([128.165.46.232]:2688 "HELO spc.esa.lanl.gov")
	by vger.kernel.org with SMTP id <S265983AbRF1OzU>;
	Thu, 28 Jun 2001 10:55:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
To: linux-kernel@vger.kernel.org
Subject: 2.4.6-pre6 cs46xx build error with CONFIG_SOUND_FUSION=m
Date: Thu, 28 Jun 2001 08:52:28 -0600
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01062808522801.01469@spc.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_SOUND_FUSION=m, I get the following error for 2.4.6-pre6 during
make modules:

cs46xx.c:386: conflicting types for `cs46xx_suspend_tbl'
cs46xxpm-24.h:39: previous declaration of `cs46xx_suspend_tbl'
cs46xx.c:387: conflicting types for `cs46xx_resume_tbl'
cs46xxpm-24.h:40: previous declaration of `cs46xx_resume_tbl'
cs46xx.c:5617: warning: initialization from incompatible pointer type
cs46xx.c:5618: warning: initialization from incompatible pointer type
cs46xx.c:5693: conflicting types for `cs46xx_suspend_tbl'
cs46xx.c:386: previous declaration of `cs46xx_suspend_tbl'
cs46xx.c:5702: conflicting types for `cs46xx_resume_tbl'
cs46xx.c:387: previous declaration of `cs46xx_resume_tbl'
make[2]: *** [cs46xx.o] Error 1

With CONFIG_SOUND_FUSION=y, 2.4.6-pre6 builds without errors,
but the sound doesn't work while running 2.4.6-pre6.  The sound does
work with 2.4.3-20mdksmp as shipped with LM 8.0.  

I've got a number of older 2.4.[3,4,5] kernels, so I'll go back and try to 
figure out when the change occured, but this is the first time I've seen 
this particular build error. 

Steven
