Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWB0HxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWB0HxE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 02:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbWB0HxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 02:53:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43944 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750976AbWB0HxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 02:53:01 -0500
Subject: Re: [PATCH 1/7] isdn4linux: Siemens Gigaset drivers - common module
From: Arjan van de Ven <arjan@infradead.org>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: Karsten Keil <kkeil@suse.de>, i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg Kroah-Hartman <gregkh@suse.de>, Tilman Schmidt <tilman@imap.cc>
In-Reply-To: <gigaset307x.2006.02.27.001.1@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.02.27.001.0@hjlipp.my-fqdn.de>
	 <gigaset307x.2006.02.27.001.1@hjlipp.my-fqdn.de>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 08:52:50 +0100
Message-Id: <1141026770.2992.38.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 07:23 +0100, Hansjoerg Lipp wrote:
> +#define IFNULL(a) \
> +       if (unlikely(!(a)))

please please get rid of this!

first of all, gcc ALREADY treats null pointer checks as unlikely,
second of all this makes code entirely unreadable, so please just
use "if (!a)" where you would want to use IFNULL

(same goes for the variants of this just below this)

