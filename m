Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbUKIQAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbUKIQAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 11:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUKIQAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 11:00:40 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:17677 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261566AbUKIQAN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 11:00:13 -0500
To: lsr@neapel230.server4you.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] Simplify checks for unwanted chars
References: <41901DD1.mail5VX1GOOYK@lsrfire.ath.cx>
	<20041109014207.GD6835@neapel230.server4you.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 10 Nov 2004 00:40:11 +0900
In-Reply-To: <20041109014207.GD6835@neapel230.server4you.de> (lsr@neapel230.server4you.de's
 message of "Tue, 9 Nov 2004 02:42:07 +0100")
Message-ID: <87is8f3uas.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lsr@neapel230.server4you.de writes:

> +static inline int vfat_skip_char(wchar_t w)
>  {
> -	for(; *s != c; ++s)
> -		if (*s == 0)
> -			return NULL;
> -	return (wchar_t *) s;
> +	return (w == 0x002E)	/* . */
> +	    || (w == 0x0020);	/* <space> */
>  }

Looks good. However, I can't apply the following patch. Can you also
do it to IS_BADCHARS()?

[PATCH 1/4] Move check for invalid chars to vfat_valid_longname()
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
