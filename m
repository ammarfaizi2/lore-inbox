Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSEEJow>; Sun, 5 May 2002 05:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290797AbSEEJov>; Sun, 5 May 2002 05:44:51 -0400
Received: from web21502.mail.yahoo.com ([66.163.169.13]:10660 "HELO
	web21502.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S290593AbSEEJou>; Sun, 5 May 2002 05:44:50 -0400
Message-ID: <20020505094446.86532.qmail@web21502.mail.yahoo.com>
Date: Sun, 5 May 2002 10:44:46 +0100 (BST)
From: =?iso-8859-1?q?Neil=20Conway?= <nconway_kernel@yahoo.co.uk>
Subject: Re: PATCH, IDE corruption, 2.4.18
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020505073656.GD2392@matchmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, downloaded 2.5.13 last night.  Executive summary: 2.5.13 IS
buggy.

Explanation: some code now differs in the code path concerned, and
ide_register_subdriver now only calls ide_dma_check for UDMA drives
(previously all DMA drives), but ultimately ide_dma_check still ends up
in ide_config_drive_speed, and that's still fuctionally the same as
2.4.

My patch doesn't apply though, due to slight changes to types and
macros, but it's not exactly a hard patch to port.  Moreover, it's
probably better to fix the problem more directly than to port my patch
;-))

Neil



__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
