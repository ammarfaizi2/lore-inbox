Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135369AbRAGH5R>; Sun, 7 Jan 2001 02:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135727AbRAGH45>; Sun, 7 Jan 2001 02:56:57 -0500
Received: from runyon.cygnus.com ([205.180.230.5]:16119 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S135369AbRAGH4r>;
	Sun, 7 Jan 2001 02:56:47 -0500
To: Matthias Juchem <juchem@uni-mannheim.de>
Cc: <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new bug report script
In-Reply-To: <Pine.LNX.4.30.0101070808560.7104-100000@gandalf.math.uni-mannheim.de>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
From: Ulrich Drepper <drepper@redhat.com>
Date: 06 Jan 2001 23:56:32 -0800
In-Reply-To: Matthias Juchem's message of "Sun, 7 Jan 2001 08:48:22 +0100 (CET)"
Message-ID: <m3k887bxsf.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Juchem <matthias@gandalf.math.uni-mannheim.de> writes:

> +    # c library 5
> +    if ( -e "/lib/libc.so.5" ) {
> +	( $v_libc5 = `/lib/libc.so.5`) =~ m/GNU C Library .+ version (\S+),/;
> +	$v_libc5 = $1;
> +    } else {
> +	$v_libc5 = "not found";
> +    }

This is wrong.  You cannot execute libc.so.5.  This only works with
glibc.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
