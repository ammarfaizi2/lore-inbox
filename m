Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267024AbTATUBa>; Mon, 20 Jan 2003 15:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267778AbTATUBa>; Mon, 20 Jan 2003 15:01:30 -0500
Received: from [195.39.17.254] ([195.39.17.254]:18436 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267024AbTATUB3>;
	Mon, 20 Jan 2003 15:01:29 -0500
Date: Mon, 20 Jan 2003 00:37:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       trivial@rustcorp.com.au, Neil Brown <neilb@cse.unsw.edu.au>,
       dwmw2@redhat.com
Subject: Re: [PATCH] [TRIVIAL] kstrdup
Message-ID: <20030119233750.GA674@elf.ucw.cz>
References: <20030114025452.656612C385@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030114025452.656612C385@lists.samba.org>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Everyone loves reimplementing strdup.  Give them a kstrdup (basically
> from drivers/md).

I believe it would be better to call it strdup.

*Or* you might want kstrdup( "foo", GFP_ATOMIC ); But if you are
hard-coding GFP_KERNEL, I believe there's no point in calling it
*k*strdup.

								Pavel
> +char *kstrdup(const char *s, int gfp)
> +{
> +	char *buf = kmalloc(strlen(s)+1, gfp);
> +	if (buf)
> +		strcpy(buf, s);
> +	return buf;
> +}



-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
