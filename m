Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbTDRH6d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 03:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262933AbTDRH6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 03:58:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28618 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262932AbTDRH6c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 03:58:32 -0400
Message-ID: <3E9FB2E9.9040308@pobox.com>
Date: Fri, 18 Apr 2003 04:10:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Trivial Russell <rusty@rustcorp.com.au>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] kstrdup
References: <20030418080205.A21702C2E1@lists.samba.org>
In-Reply-To: <20030418080205.A21702C2E1@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Trivial Russell wrote:
> +char *kstrdup(const char *s, int gfp)
> +{
> +	char *buf = kmalloc(strlen(s)+1, gfp);
> +	if (buf)
> +		strcpy(buf, s);
> +	return buf;
> +}



You should save the strlen result to a temp var, and then s/strcpy/memcpy/

	Jeff



