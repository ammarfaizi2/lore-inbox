Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWJLMcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWJLMcJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 08:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWJLMcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 08:32:09 -0400
Received: from 24-75-174-210-st.chvlva.adelphia.net ([24.75.174.210]:39572
	"EHLO sanosuke.troilus.org") by vger.kernel.org with ESMTP
	id S1750741AbWJLMcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 08:32:07 -0400
To: "Dongsheng Song" <dongsheng.song@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: maybe headers(linux/aio.h) bug ?
From: Michael Poole <mdpoole@troilus.org>
Date: Thu, 12 Oct 2006 08:32:06 -0400
In-Reply-To: <4b3406f0610120527g42bfbc44q45b31dc07f5968de@mail.gmail.com> (Dongsheng Song's message of "Thu, 12 Oct 2006 20:27:28 +0800")
Message-ID: <87wt7567g9.fsf@graviton.dyn.troilus.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
References: <4b3406f0610120527g42bfbc44q45b31dc07f5968de@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dongsheng Song writes:

> Whenever I include linux aio header,  the compile errors occured:
>
> $  cat test.c
> #include <linux/types.h>
> #include <linux/unistd.h>
> #include <linux/aio.h>

Including kernel header files directly from userspace is not supported
and is almost always (some just say "always") a very bad idea.  If you
want to use the C library's AIO support, use its <aio.h> header.

Michael Poole
