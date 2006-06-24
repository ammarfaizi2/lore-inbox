Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWFXSO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWFXSO3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 14:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWFXSO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 14:14:29 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:5330
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751020AbWFXSO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 14:14:28 -0400
Message-ID: <449D8105.3060903@lsrfire.ath.cx>
Date: Sat, 24 Jun 2006 20:14:29 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Daniel <damage@rooties.de>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Kernelsources writeable for everyone?!
References: <200606242000.51024.damage@rooties.de>
In-Reply-To: <200606242000.51024.damage@rooties.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel schrieb:
> Hi,
> may be this was reported/asked 999999999 times, but here ist the 1000000000th:

You're close. :-P

> I have downloaded linux-2.6.17.1 10 min ago and I noticed that every file is 
> writeable by everyone. What's going on there?
> 
> coffee src # tar -jtvf linux-2.6.17.1.tar.bz2
> drwxrwxrwx git/git           0 2006-06-20 11:31:55 linux-2.6.17.1/

This is intentional.  You can set the permissions to anything you want
by making tar honor the umask setting -- without needing to run chmod
after extracting.

So either use the --no-same-permissions option of GNU tar, or simply
don't run tar as root (then this option is on by default), which is a
good idea anyway.

René
