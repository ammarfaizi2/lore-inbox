Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264637AbTFAO4d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 10:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbTFAO4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 10:56:32 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:8902 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S264637AbTFAO4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 10:56:31 -0400
Date: Sun, 1 Jun 2003 08:09:51 -0700
From: Larry McVoy <lm@bitmover.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Larry McVoy <lm@bitmover.com>, Willy Tarreau <willy@w.ods.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Question about style when converting from K&R to ANSI C.
Message-ID: <20030601150951.GC3641@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Steven Cole <elenstev@mesatop.com>, Larry McVoy <lm@bitmover.com>,
	Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
References: <1054446976.19557.23.camel@spc> <20030601132626.GA3012@work.bitmover.com> <20030601134942.GA10750@alpha.home.local> <20030601140602.GA3641@work.bitmover.com> <1054479734.19552.51.camel@spc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054479734.19552.51.camel@spc>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /*ARGSUSED*/
> -static unsigned long
> -insert_bba (insn, value, errmsg)
> -     unsigned long insn;
> -     long value;
> -     const char **errmsg;
> +static unsigned long insert_bba(
> +       unsigned long insn,
> +       long value,
> +       const char **errmsg
> +)
> {
>    return insn | (((insn >> 16) & 0x1f) << 11);
> }

Of the following, the original is clearly outdated so we can all agree that
can go.  I'm not real found of Linus' style either.  What's wrong with the
two traditional forms?

/* ============== original ============== */
static unsigned long
insert_bba (insn, value, errmsg)
	unsigned long insn;
	long value;
	const char **errmsg;
{
	return insn | (((insn >> 16) & 0x1f) << 11);
}

/* ============== linus ============== */
static unsigned long insert_bba(
	unsigned long insn;
	long value;
	const char **errmsg;
)
{
	return insn | (((insn >> 16) & 0x1f) << 11);
}

/* ============== traditional ============== */
static unsigned long
insert_bba(unsigned long insn; long value; const char **errmsg)
{
	return insn | (((insn >> 16) & 0x1f) << 11);
}

/* ============== traditional (lotso args) ============== */
static unsigned long
insert_bba(
	register unsigned const int some_big_fat_variable_name;
	unsigned long insn;
	long value;
	const char **errmsg)
{
	return insn | (((insn >> 16) & 0x1f) << 11);
}

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
