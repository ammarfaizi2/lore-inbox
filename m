Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267062AbSKSRpP>; Tue, 19 Nov 2002 12:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267068AbSKSRpP>; Tue, 19 Nov 2002 12:45:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16403 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267062AbSKSRpO>;
	Tue, 19 Nov 2002 12:45:14 -0500
Message-ID: <3DDA7A30.4010403@pobox.com>
Date: Tue, 19 Nov 2002 12:51:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Reppert <arashi@arashi.yi.org>
CC: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] mii module broken under new scheme
References: <20021119115041.11ece7dc.arashi@arashi.yi.org>
In-Reply-To: <20021119115041.11ece7dc.arashi@arashi.yi.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Reppert wrote:

> drivers/net/mii.c doesn't export module init/cleanup functions. That 
> means it
> can't be loaded under the new module scheme. This patch adds do-nothing
> functions for it, which allows it to load. (8139too depends on mii, so
> without this I don't have network.)



ahhh!   I was wondering what was up, but since I was busy with other 
things I just compiled it into the kernel and continued on my way.

That's a bug in the new module loader.

	Jeff



