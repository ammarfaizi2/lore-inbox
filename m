Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWGPUYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWGPUYZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 16:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWGPUYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 16:24:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57497 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750950AbWGPUYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 16:24:24 -0400
Subject: Re: [PATCH] V4L: struct video_device corruption
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Robert Fitzsimons <robfitz@273k.net>
Cc: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       greg@kroah.com, 76306.1226@compuserve.com, fork0@t-online.de,
       linux-kernel@vger.kernel.org, shemminger@osdl.org,
       video4linux-list@redhat.com, v4l-dvb-maintainer@linuxtv.org
In-Reply-To: <20060715230849.GA3385@localhost>
References: <200607130047_MC3-1-C4D3-43D6@compuserve.com>
	 <20060713050541.GA31257@kroah.com>
	 <20060712222407.d737129c.rdunlap@xenotime.net>
	 <20060712224453.5faeea4a.akpm@osdl.org>  <20060715230849.GA3385@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 15 Jul 2006 22:31:04 -0300
Message-Id: <1153013464.4755.35.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sáb, 2006-07-15 às 23:08 +0000, Robert Fitzsimons escreveu:
> The layout of struct video_device would change depending on whether
> videodev.h (V4L1) was include or not before v4l2-dev.h, which caused
> the structure to get corrupted.  
Hmm... good point! However, I the proper solution would be to trust on
CONFIG_VIDEO_V4L1_COMPAT or CONFIG_VIDEO_V4L1 instead. it makes no sense
to keep a pointer to an unsupported callback, when V4L1 is not selected.


Cheers, 
Mauro.

