Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbVKESeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVKESeJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVKESeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:34:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7331 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932184AbVKESeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:34:07 -0500
Date: Sat, 5 Nov 2005 10:33:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jon Masters <jonathan@jonmasters.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: fix-readonly-policy-use-and-floppy-ro-rw-status
Message-Id: <20051105103358.2e61687f.akpm@osdl.org>
In-Reply-To: <20051105182728.GB27767@apogee.jonmasters.org>
References: <20051105182728.GB27767@apogee.jonmasters.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Masters <jonathan@jonmasters.org> wrote:
>
> [PATCH]: This modifies the gendisk and hd_struct structs to replace "policy"
>  with "readonly" (as that's the only use for this field). It also introduces a
>  new function disk_read_only, which behaves like the corresponding device
>  functions do. I've also replaced direct usage of the old policy fields with
>  calls to the appropriate function.

These are separate things and should be done in separate patches, please.

Because, for exmaple, we may decide to revert the floppy change only. 
Because, as I said off-list, being able to do `remount,rw' of a floppy after
having flipped its switch is useful.
