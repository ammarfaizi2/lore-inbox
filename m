Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161163AbWJ3Rej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161163AbWJ3Rej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161203AbWJ3Rej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:34:39 -0500
Received: from smtp151.iad.emailsrvr.com ([207.97.245.151]:20375 "EHLO
	smtp151.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S1161163AbWJ3Rei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:34:38 -0500
Subject: splice blocks indefinitely when len > 64k?
From: Daniel Drake <ddrake@brontes3d.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 30 Oct 2006 11:39:50 -0500
Message-Id: <1162226390.7280.18.camel@systems03.lan.brontes3d.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm experimenting with splice and have run into some unusual behaviour.

I am using the utilities in git://brick.kernel.dk/data/git/splice.git

In splice.h, when changing SPLICE_SIZE from:

#define SPLICE_SIZE (64*1024)

to

#define SPLICE_SIZE ((64*1024)+1)

splice-cp hangs indefinitely when copying files sized 65537 bytes or
more. It hangs on the first splice() call.

Is this a bug? I'd like to be able to copy much more than 64kb on a
single splice call.

Thanks!
Daniel


