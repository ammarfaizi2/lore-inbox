Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVATTNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVATTNg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 14:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVATTJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 14:09:40 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:50645 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261503AbVATTHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:07:53 -0500
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt
	scheduling
From: Lee Revell <rlrevell@joe-job.com>
To: ross@lug.udel.edu
Cc: Paul Davis <paul@linuxaudiosystems.com>, "Jack O'Quin" <joq@io.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20050120174939.GA15920@jose.lug.udel.edu>
References: <87pt00b01i.fsf@sulphur.joq.us>
	 <200501201542.j0KFgOwo019109@localhost.localdomain>
	 <20050120174939.GA15920@jose.lug.udel.edu>
Content-Type: text/plain
Date: Thu, 20 Jan 2005 14:07:48 -0500
Message-Id: <1106248068.17524.8.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-20 at 12:49 -0500, ross@lug.udel.edu wrote:
> It's been a long while since I followed ReiserFS development closely,
> *however*, this issue used to be a common problem ReiserFS - when
> free space starts to drop below 10%, performace takes a big hit.  So
> performance improved when space was cleared up.
> 

To be fair to Reiserfs, many UNIX filesystems have done this on purpose,
all the way back to FFS I think.  Once free space drops below 10%, they
change their allocation scheme to favor efficiency over speed.  Probably
this behavior doesn't make sense on a 120GB disk with 11GB free.  But it
certainly does on a 300MB disk when you get down to 30 ;-)

Lee

