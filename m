Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVCGK3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVCGK3L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 05:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVCGK3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 05:29:11 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:50113 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261739AbVCGK3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 05:29:01 -0500
Date: Mon, 7 Mar 2005 11:28:43 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Edgar, Bob" <Bob.Edgar@commerzbankib.com>
Cc: "'Jesper Juhl'" <juhl-lkml@dif.dk>, Steve French <sfrench@us.ibm.com>,
       Luca Tettamanti <kronos@kronoz.cjb.net>,
       samba-technical <samba-technical@lists.samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Domen Puncer <domen@coderock.org>
Subject: Re: [PATCH] whitespace cleanups for fs/cifs/file.c
Message-ID: <20050307102843.GB2198@wohnheim.fh-wedel.de>
References: <9D248E1E43ABD411A9B600508BAF6E9B0C737269@xmx7fraib.fra.ib.commerzbank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9D248E1E43ABD411A9B600508BAF6E9B0C737269@xmx7fraib.fra.ib.commerzbank.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 March 2005 10:26:40 +0100, Edgar, Bob wrote:
> 
> I lurk on the list and didn't comment last time but there is one aspect
> of this patch that I think is "bad" style. The function declaration should
> not be on the same line with the type. Why? Try to find the file where a
> function is defined instead of used. If you grep "^funcname" you'll find
> it quite simply. The same is true in YFE (mine being vi) /^funcname gets
> me there in one shot.
> 
> This may not seem an important thing but when you are coming into a
> project cold and don't know how anything works or where it lives it
> can be very important. Consider trying to find where some common
> function from a library is defined in a project with sever 1000 files.

This point has been discussed before, also regarding Jesper's work.
In short, Linus prefers the style you dislike, but doesn't enforce
things too rigidly.  Imo the "grep" argument doesn't really matter and
both styles have advantages sometimes.

Now to solve some of your problems a different way (in vim style):
o $ make tags
o $ vi foo.c
o move over any function
o ^]
o ^t
o :ts

o $ vi bar.c
o move over any identifier
o *
o #

Works like a charm for me.  lxr is still slightly better, but the
lacking integration into my editor makes is inferior in 99.9% of all
cases.

Jörn

-- 
Data expands to fill the space available for storage.
-- Parkinson's Law
