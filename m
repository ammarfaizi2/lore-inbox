Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVCRUzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVCRUzh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 15:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVCRUzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 15:55:36 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:36499 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261202AbVCRUza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 15:55:30 -0500
Message-ID: <423B15DD.9020803@suse.de>
Date: Fri, 18 Mar 2005 18:54:37 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Erik_Andr=E9n?= <erik.andren@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Suspend-to-disk woes
References: <423B01A3.8090501@gmail.com>
In-Reply-To: <423B01A3.8090501@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andrén wrote:

> My question is: Why isn't there a check before resuming a 
> suspend-to-disk image if the system has booted another kernel since the 
> suspend to prevent this kind of hassle?

Just provide a patch which does this. Hint: this is highly nontrivial.
If you boot a kernel, that does not know swsusp (and if it knew, it
would have invalidated the suspend image in the swap), or which does not
have the necessary information (because of a missing resume= parameter),
this kernel cannot do much.

Stefan

