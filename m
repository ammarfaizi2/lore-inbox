Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWAKJXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWAKJXf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 04:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWAKJXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 04:23:35 -0500
Received: from f48.mail.ru ([194.67.57.84]:35344 "EHLO f48.mail.ru")
	by vger.kernel.org with ESMTP id S1751390AbWAKJXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 04:23:34 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re[2]: [PATCH]trivial: add CDC_RAM to ide-cd capabilities mask
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Wed, 11 Jan 2006 12:23:27 +0300
In-Reply-To: <200601110327_MC3-1-B5A3-6E0F@compuserve.com>
Reply-To: Andrey Borzenkov <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1EwcCV-00013E-00.arvidjaar-mail-ru@f48.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> drive name:             sr0
> drive speed:            1
> drive # of slots:       1
> Can close tray:         1
> Can open tray:          1
> Can lock tray:          1
> Can change speed:       0
> Can select disk:        0
> Can read multisession:  1
> Can read MCN:           1
> Reports media changed:  1
> Can play audio:         1
> Can write CD-R:         0
> Can write CD-RW:        0
> Can read DVD:           0
> Can write DVD-R:        0
> Can write DVD-RAM:      0
> Can read MRW:           1
> Can write MRW:          1
> Can write RAM:          1
> 
> There's no way this drive knows anything about MRW or random-access writing:
> 
...
> And an ATAPI DVD-ROM also reports (before the above patch):
> 
> Can read MRW:           1
> Can write MRW:          1
> Can write RAM:          1
> 

I know. There were patches from Jens for both 2.4 and 2.6 that add MRW
support to ide-cd for sure; may be for sr too, am not sure. Jens, any
reasons for them not in mainstream? Otherwise probably ide-cd and sr should
not announce MRW capabiliies at all, it is too confusing; I'll send a patch
when I am at home.

-andrey
