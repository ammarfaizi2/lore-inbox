Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315602AbSECIVB>; Fri, 3 May 2002 04:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315601AbSECIUB>; Fri, 3 May 2002 04:20:01 -0400
Received: from [195.39.17.254] ([195.39.17.254]:23955 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S315598AbSECITX>;
	Fri, 3 May 2002 04:19:23 -0400
Date: Fri, 3 May 2002 10:03:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing checks in exec_permission_light()
Message-ID: <20020503080356.GB232@elf.ucw.cz>
In-Reply-To: <Pine.GSO.4.21.0204302340340.10523-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +	if (S_ISDIR(inode->i_mode) && capable(CAP_DAC_READ_SEARCH))
> +		return 0;

Is this right? This means that root can do cat /, no? That does not
seem like expected behaviour.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
