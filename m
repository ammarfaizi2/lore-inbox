Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266757AbUF3QKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266757AbUF3QKV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 12:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266741AbUF3QIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 12:08:53 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:54438 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266749AbUF3QIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 12:08:35 -0400
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: s390(64) per_cpu in modules (ipv6)
X-Message-Flag: Warning: May contain useful information
References: <20040630130442.GA2440@mschwid3.boeblingen.de.ibm.com>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 30 Jun 2004 09:07:08 -0700
In-Reply-To: <20040630130442.GA2440@mschwid3.boeblingen.de.ibm.com> (Martin
 Schwidefsky's message of "Wed, 30 Jun 2004 15:04:42 +0200")
Message-ID: <52oen1jahf.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 Jun 2004 16:07:08.0404 (UTC) FILETIME=[4B568340:01C45EBC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Martin> __attribute_used__ isn't really what we want. If a
    Martin> statically defined per cpu variable isn't used in the C
    Martin> file then gcc should be allowed to remove it. It's not
    Martin> used after all.  What we need is a way to tell the
    Martin> compiler that an inline assembly uses a variable without
    Martin> passing any kind of address of the variable to it.

Actually my understanding is that __attribute_used__ is intended for
exactly that: to let the compiler know that something that is
apparently unused by the C code is actually used by inline assembly.
I'm sure your solution is fine as well but I think this type of
situation is exactly what __attribute_used__ is for.  For example it
is attached to the modversions ____versions array so that it is not
discarded by the compiler.

Best,
  Roland
