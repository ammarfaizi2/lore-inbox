Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932780AbVJ3Bzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932780AbVJ3Bzg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 21:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932781AbVJ3Bzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 21:55:36 -0400
Received: from xenotime.net ([66.160.160.81]:19146 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932780AbVJ3Bzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 21:55:35 -0400
Date: Sat, 29 Oct 2005 18:55:33 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multiple MODULE_AUTHOR statements
Message-Id: <20051029185533.76f53024.rdunlap@xenotime.net>
In-Reply-To: <1130590873.5396.2.camel@blade>
References: <1130590873.5396.2.camel@blade>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Oct 2005 15:01:13 +0200 Marcel Holtmann wrote:

> Hi guys,
> 
> I saw some people adding multiple MODULE_AUTHOR statements to their
> drivers if they wanna mention more than one author. I normally used a
> comma separated list. Is it valid to use multiple statements? If yes,
> then I will change my drivers to use the same approach.

It works.  I.e., modinfo will list multiple MODULE_AUTHOR entries.
MODULE_AUTHOR() just creates a special data section, nothing magic
about it.  Several are allowed (in general).

However, include/linux/module.h says:
/* Author, ideally of form NAME <EMAIL>[, NAME <EMAIL>]*[ and NAME <EMAIL>] */
#define MODULE_AUTHOR(_author) MODULE_INFO(author, _author)

so someone thought that they should all be listed together (in one entry).

---
~Randy
