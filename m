Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWDQWJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWDQWJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 18:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWDQWJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 18:09:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42114 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751342AbWDQWJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 18:09:27 -0400
Subject: Re: Slab corruption after unloading a module
From: Arjan van de Ven <arjan@infradead.org>
To: zhiyi huang <hzy@cs.otago.ac.nz>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <F77F3A5F-D618-4F7F-A266-14391E5DD739@cs.otago.ac.nz>
References: <200604161443.21653.arvidjaar@mail.ru>
	 <F77F3A5F-D618-4F7F-A266-14391E5DD739@cs.otago.ac.nz>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 00:09:20 +0200
Message-Id: <1145311760.2847.97.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 10:08 +1200, zhiyi huang wrote:
> >
> >> There was no problem if I just load and unload the module. But if I
> >> write to the device using "ls > /dev/temp" and then unload the
> >> module, I would get slab corruption.
> >
> > you return different value as what has really been consumed:
> >
> >>         if (*f_pos + count > MAX_DSIZE)
> >>                 count1 = MAX_DSIZE - *f_pos;
> >>
> >>         if (copy_from_user (temp_dev->data+*f_pos, buf, count1)) {

this is still buggy.. what if f_pos is huge???


