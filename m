Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVAaVNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVAaVNK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 16:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVAaVNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 16:13:09 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:13644 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261368AbVAaVIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 16:08:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=hp2chCaHSHylmd+JGeaeq2xuEo0vRb8+zwHYNBP5tPC6uXq45Tf5xru9epd7QwEvFODMJ2FiDCzS/7LL2lKb4W1KTNK+A4AmmQjADjjcKENawIRY3Gy1QjnrXxCkuGr6TWTQeateA/1ehAytqUPyIZ77qAHH8RSC18GJhYLIVeY=
Message-ID: <a36005b505013113084015a85@mail.gmail.com>
Date: Mon, 31 Jan 2005 13:08:49 -0800
From: Ulrich Drepper <drepper@gmail.com>
Reply-To: Ulrich Drepper <drepper@gmail.com>
To: Ben Greear <greearb@candelatech.com>
Subject: Re: close-exec flag not working in 2.6.9?
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41FDE497.6040308@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41FDE497.6040308@candelatech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2005 23:56:07 -0800, Ben Greear <greearb@candelatech.com> wrote:
>    flags = fcntl(s, F_GETFL);
>    flags |= (FD_CLOEXEC);
>    if (fcntl(s, F_SETFL, flags) < 0) {

These have to be F_GETFD and F_SETFD respectively.  Note L -> D.
