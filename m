Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbTHYQhv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 12:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbTHYQhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 12:37:51 -0400
Received: from [213.39.233.138] ([213.39.233.138]:33745 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261917AbTHYQhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 12:37:50 -0400
Date: Mon, 25 Aug 2003 18:37:45 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Dan Aloni <da-x@gmx.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] One strdup() to rule them all
Message-ID: <20030825163745.GA17608@wohnheim.fh-wedel.de>
References: <20030825161435.GB8961@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030825161435.GB8961@callisto.yi.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 August 2003 19:14:35 +0300, Dan Aloni wrote:
> 
> While working on the fix to network devices names and sysctl,
> I fought to urge to create yet another strdup() implementation
> This came up.

Nice one.

> +/**
> + * strdup - Allocate a copy of a string.
> + * @s: The string to copy. Must not be NULL.
> + *
> + * returns the address of the allocation, or NULL on
> + * error. 
> + */
> +char *strdup(const char *s)
> +{
> +	char *rv = kmalloc(strlen(s)+1, GFP_KERNEL);
> +	if (rv)
> +		strcpy(rv, s);
> +	return rv;
> +}

My gut feeling is always afraid when something "must not be NULL",
someone will ignore this and Bad Things (tm) happen.  Is strdup ever
used such performance critical code that the extra check would hurt?

Apart from that, well done.

Jörn

-- 
Eighty percent of success is showing up.
-- Woody Allen
