Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267543AbUG3ABm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267543AbUG3ABm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 20:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267538AbUG3ABl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 20:01:41 -0400
Received: from cantor.suse.de ([195.135.220.2]:47799 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267535AbUG2Xxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 19:53:41 -0400
To: Greg Edwards <edwardsg@sgi.com>
Cc: kai@germaschewski.name, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add ia64 support to rpm Makefile target
References: <20040729180732.GA15920@sgi.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: So this is what it feels like to be potato salad
Date: Fri, 30 Jul 2004 01:52:01 +0200
In-Reply-To: <20040729180732.GA15920@sgi.com> (Greg Edwards's message of
 "Thu, 29 Jul 2004 13:07:32 -0500")
Message-ID: <jek6wmz80u.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Edwards <edwardsg@sgi.com> writes:

> diff -Nru a/scripts/package/mkspec b/scripts/package/mkspec
> --- a/scripts/package/mkspec	2004-07-29 13:04:34 -05:00
> +++ b/scripts/package/mkspec	2004-07-29 13:04:34 -05:00
> @@ -43,10 +43,21 @@
>  echo "make clean && make"
>  echo ""
>  echo "%install"
> -echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
> +
> +if [[ "$ARCH" != "ia64" ]]; then
> +	echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
> +else
> +	echo 'mkdir -p $RPM_BUILD_ROOT/boot/efi $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
> +fi

How about using %ifarch ia64 in the generated spec file?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
