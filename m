Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264794AbTE1Q2W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 12:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbTE1Q2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 12:28:22 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:5642 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S264794AbTE1Q2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 12:28:21 -0400
Date: Wed, 28 May 2003 18:41:34 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Michael Buesch <fsdeveloper@yahoo.de>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix menuconfig if saving on different fs
In-Reply-To: <200305262135.25363.fsdeveloper@yahoo.de>
Message-ID: <Pine.LNX.4.44.0305281837500.5042-100000@serv>
References: <200305262135.25363.fsdeveloper@yahoo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 26 May 2003, Michael Buesch wrote:

> +			while ((l = fgetc(out)) != EOF) {
> +				if (fputc(l, out_new) == EOF) {
> +					fclose(out);
> +					fclose(out_new);
> +					return 1;
> +				}

I don't really like this file copy, I'd rather create the file in the 
destination directory. I fixed this here a bit different.

bye, Roman

