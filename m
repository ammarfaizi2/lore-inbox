Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265951AbSKBMo2>; Sat, 2 Nov 2002 07:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265956AbSKBMo2>; Sat, 2 Nov 2002 07:44:28 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2820 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265951AbSKBMo1>;
	Sat, 2 Nov 2002 07:44:27 -0500
Date: Sat, 2 Nov 2002 00:27:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Cc: torvalds@transmeta.com, viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.45: Filesystem capabilities
Message-ID: <20021101232758.GB289@elf.ucw.cz>
References: <87znsuy9ho.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87znsuy9ho.fsf@goat.bogus.local>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hi Linus,
> 
> This patch implements filesystem capabilities. It allows to run
> privileged executables without the need for suid root.

This is gross hack:

> +static char __capname[] = ".capabilities";
> +
> +static int __is_capname(const char *name)
> +{
> +	if (*name != __capname[0])
> +		return 0;
> +
> +	return !strcmp(name, __capname);
> +}

Yup. Magic filename. With ACLs going in 2.5 and with ext2 support for
arbitrary metadata, doing capabilities right might be feasible now.

							Pavel

-- 
When do you have heart between your knees?
