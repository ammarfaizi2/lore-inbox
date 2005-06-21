Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVFUTrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVFUTrQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 15:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbVFUTqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 15:46:17 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:9454 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262265AbVFUTnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 15:43:49 -0400
Message-ID: <42B86DF1.7000102@ens-lyon.org>
Date: Tue, 21 Jun 2005 21:43:45 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: get_user_pages() and shared memory question
References: <42B82DF2.2050708@ammasso.com>
In-Reply-To: <42B82DF2.2050708@ammasso.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21.06.2005 17:10, Timur Tabi a écrit :
> Let's say an application allocates some shared memory, and then calls
> into a driver which calls get_user_pages().  The driver exits without
> releasing the pages, so they now have a reference count on them.

Preventing the driver from doing this would probably be the
right solution here... If the driver called get_user_pages,
it is its responsibility to release the pages.

Brice
