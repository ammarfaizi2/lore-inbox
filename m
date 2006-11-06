Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbWKFH5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWKFH5i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 02:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWKFH5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 02:57:37 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:21378 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030391AbWKFH5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 02:57:37 -0500
Message-ID: <454EEAEB.5030606@pobox.com>
Date: Mon, 06 Nov 2006 02:57:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Florin Malita <fmalita@gmail.com>
CC: akpm@osdl.org, linville@tuxdriver.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] airo.c: check returned values
References: <452C06A6.4030408@gmail.com>
In-Reply-To: <452C06A6.4030408@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florin Malita wrote:
> create_proc_entry() can fail and return NULL in setup_proc_entry(), the
> result must be checked before dereferencing. (Coverity ID 1443)
> 
> init_wifidev() & setup_proc_entry() can also fail in _init_airo_card().
> 
> This adds the checks & cleanup code and removes some whitespace.
> 
> Signed-off-by: Florin Malita <fmalita@gmail.com>

NAK:  create_proc_entry() is complicated.  You are correct it can fail 
-- but to add to the confusion, when CONFIG_PROC_FS is disabled, the 
wrapper will also return NULL -- which is NOT a failure case.

	Jeff



