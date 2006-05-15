Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWEOJfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWEOJfZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 05:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWEOJfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 05:35:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36484 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932318AbWEOJfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 05:35:25 -0400
Date: Mon, 15 May 2006 05:34:57 -0400
From: Alan Cox <alan@redhat.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Moxa Technologies <support@moxa.com.tw>,
       Alan Cox <alan@redhat.com>, Martin Mares <mj@ucw.cz>
Subject: Re: [PATCH] fix dangerous pointer derefs and remove pointless casts in MOXA driver
Message-ID: <20060515093457.GA9780@devserv.devel.redhat.com>
References: <200605140349.36122.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605140349.36122.jesper.juhl@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2006 at 03:49:35AM +0200, Jesper Juhl wrote:
> If mxser_write() gets called with a NULL 'tty' pointer, then the initial
> assignment of tty->driver_data to info will explode.

If mxser_write gets called with a NULL pointer then you've already got such
serious problems it isn't worth checking

> Please consider for inclusion.

Just delete the checks.  Also the little cast cleanup looks good so submit
that as a separate patch too.

Alan


