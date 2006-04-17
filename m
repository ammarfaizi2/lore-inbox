Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWDQXzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWDQXzH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 19:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWDQXzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 19:55:06 -0400
Received: from smtpout.mac.com ([17.250.248.174]:22727 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932070AbWDQXzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 19:55:05 -0400
In-Reply-To: <200604180052.19361.mb@bu3sch.de>
References: <20060417211128.GA6861@kroah.com> <20060417211206.GB6861@kroah.com> <200604180052.19361.mb@bu3sch.de>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3C8DBC09-D9F7-4790-BBE0-268B93FF907E@mac.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       torvalds@osdl.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Linux 2.6.16.6
Date: Mon, 17 Apr 2006 19:54:37 -0400
To: Michael Buesch <mb@bu3sch.de>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 17, 2006, at 18:52:18, Michael Buesch wrote:
> Is only one / possible, or better something like this?
>
> 	/* ewww... some of these buggers have / in name... */
> 	s = name;
> 	while ((s = strchr(s, '/')) != NULL)
> 		*s = '!';

Or perhaps the more obvious, efficient, and function-call-free:
for (s = name; *s; s++)
	if (*s == '/')
		*s = '!';

Cheers,
Kyle Moffett

