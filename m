Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261896AbTCQSfF>; Mon, 17 Mar 2003 13:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261897AbTCQSfF>; Mon, 17 Mar 2003 13:35:05 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:7436 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261896AbTCQSfE>;
	Mon, 17 Mar 2003 13:35:04 -0500
Date: Mon, 17 Mar 2003 19:45:57 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andries.Brouwer@cwi.nl
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix affs/super.c
Message-ID: <20030317184557.GC4281@mars.ravnborg.org>
Mail-Followup-To: Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <UTC200303171509.h2HF95N15581.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200303171509.h2HF95N15581.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 04:09:05PM +0100, Andries.Brouwer@cwi.nl wrote:
> -	memset(sbi, 0, sizeof(*AFFS_SB));
> +	memset(sbi, 0, sizeof(struct affs_sb_info));

Or:
> +	memset(sbi, 0, sizeof(*sbi));

In this way you do not need to update the memset when you
rename/change the type.

	Sam
