Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbUKCOXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbUKCOXj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 09:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbUKCOXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 09:23:39 -0500
Received: from cantor.suse.de ([195.135.220.2]:23964 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261617AbUKCOXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 09:23:36 -0500
To: =?iso-8859-1?q?Gerrit_Bruchh=E4user?= 
	<gbruchhaeuser@orga-systems.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: accept does not return in case a signal arrives
References: <4188DC90.9030503@orga-systems.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Put FIVE DOZEN red GIRDLES in each CIRCULAR OPENING!!
Date: Wed, 03 Nov 2004 15:18:17 +0100
In-Reply-To: <4188DC90.9030503@orga-systems.com> (Gerrit
 =?iso-8859-1?q?Bruchh=E4user's?= message of "Wed, 03 Nov 2004 14:26:40 +0100")
Message-ID: <je3bzrrp7a.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerrit Bruchhäuser <gbruchhaeuser@orga-systems.com> writes:

> Given the following sample:
>
> ,----[ main.cc ]
> | #include <sys/types.h>
> | #include <sys/socket.h>
> | #include <errno.h>
> | #include <string.h>
> | #include <stdio.h>
> | #include <stdlib.h>
> | #include <resolv.h>
> | #include <signal.h>
> |
> | #define CHECK_RET_M(arg, x) \
> |   if (-1 == (x) && errno != EINTR) { \
> |      printf("System call '%s' failed: %s\n", #arg, strerror(errno)); \
> |      exit(1); \
> |   }
> |
> | typedef struct sockaddr SA;
> |
> | static void TermHandler(int signu)
> | {
> |    // Nothing
> | }
> |
> | int main(int argc, char *argv[])
> | {
> |   // Create signal handler 4 SIGTERM
> |   signal(SIGTERM, &TermHandler);

Use sigaction.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
