Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVARCVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVARCVy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 21:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVARCTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 21:19:40 -0500
Received: from smtpout2.uol.com.br ([200.221.4.193]:15026 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261153AbVARCDd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 21:03:33 -0500
Date: Tue, 18 Jan 2005 00:03:25 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/13] FAT: Return better error codes from vfat_valid_longname()
Message-ID: <20050118020324.GC11257@ime.usp.br>
Mail-Followup-To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <87pt04oszi.fsf@devron.myhome.or.jp> <87llasosxu.fsf@devron.myhome.or.jp> <87hdlgoswe.fsf_-_@devron.myhome.or.jp> <87d5w4osuv.fsf_-_@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d5w4osuv.fsf_-_@devron.myhome.or.jp>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 18 2005, OGAWA Hirofumi wrote:
>  static int vfat_valid_longname(const unsigned char *name, unsigned int len)
>  {
> -	if (len && name[len-1] == ' ')
> -		return 0;
> +	if (name[len - 1] == ' ')
> +		return -EINVAL;

Sorry for the stupid question, but is len guaranteed to be always greater
than zero?

Otherwise, I think that the test with len would be warranted.  And, if that
is the case, wouldn't it be better to have it explicitly say if (len > 0...)?

Just curious. And sorry again for the stupid question. But as Knuth says,
"premature optimization is the root of all evil".

Perhaps I'm way too much into proving invariants of algorithms. :-)


Thanks for your work, Rogério.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
