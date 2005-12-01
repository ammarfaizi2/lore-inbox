Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbVLANnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVLANnu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 08:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbVLANnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 08:43:50 -0500
Received: from mail3.netbeat.de ([193.254.185.27]:29873 "HELO mail3.netbeat.de")
	by vger.kernel.org with SMTP id S932231AbVLANnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 08:43:50 -0500
Subject: Re: [PATCH 0/4] linux-2.6-block: deactivating pagecache for
	benchmarks
From: Dirk Henning Gerdes <mail@dirk-gerdes.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1133443765.2853.39.camel@laptopd505.fenrus.org>
References: <1133443051.6110.32.camel@noti>
	 <1133443765.2853.39.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 01 Dec 2005 14:43:43 +0100
Message-Id: <1133444623.6110.57.camel@noti>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Probably I should have mentioned, how my benchmark should look like:

I have written a little c-program opening several files for reading and
writing. 
The dentry-cache would only play a role the first time, the files are
opened. I'm not quite sure about the inode-cache. 
I check if the page has buffer, and mark them as not uptodate, too. So
the buffer-cache is disabled, too.

I'm using ext2/ext3. I don't think, they use any additional caches.

But anyway: Could you explain your fake-umount idea a little more ?

Am Donnerstag, den 01.12.2005, 14:29 +0100 schrieb Arjan van de Ven:
> On Thu, 2005-12-01 at 14:17 +0100, Dirk Henning Gerdes wrote:
> > Hi Jens!
> > 
> > For doing benchmarks on the I/O-Schedulers, I thought it would be very
> > useful to disable the pagecache.
> 
> 
> for benchmarks this is not enough though, you also need to clean the
> inode and dentry caches, as well as any filesystem specific caches
> (might be buffer cache)..... 
> at which point it's probably nicer to just fake a limited umount since
> that has to do all of that anyway
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Dirk Henning Gerdes
Bönnersdyk 47
47803 Krefeld

Tel:  02151-755745
      0174-7776640
Mail: mail@dirk-gerdes.de

