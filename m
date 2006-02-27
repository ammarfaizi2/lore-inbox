Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751662AbWB0IBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbWB0IBx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbWB0IBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:01:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27857 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751661AbWB0IBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:01:51 -0500
Subject: Re: [PATCH 2/7] isdn4linux: Siemens Gigaset drivers - event layer
From: Arjan van de Ven <arjan@infradead.org>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: Karsten Keil <kkeil@suse.de>, i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg Kroah-Hartman <gregkh@suse.de>, Tilman Schmidt <tilman@imap.cc>
In-Reply-To: <gigaset307x.2006.02.27.001.2@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.02.27.001.0@hjlipp.my-fqdn.de>
	 <gigaset307x.2006.02.27.001.1@hjlipp.my-fqdn.de>
	 <gigaset307x.2006.02.27.001.2@hjlipp.my-fqdn.de>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 09:01:48 +0100
Message-Id: <1141027308.2992.47.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 07:23 +0100, Hansjoerg Lipp wrote:
> +static inline void new_index(atomic_t *index, int max)
> +{
> +       if (atomic_read(index) == max)  //FIXME race?
> +               atomic_set(index, 0);
> +       else
> +               atomic_inc(index);
> +}

yes.. that's a race.....


