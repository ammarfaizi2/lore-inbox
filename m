Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUCVHFT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 02:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbUCVHFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 02:05:18 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:13988
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261746AbUCVHFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 02:05:14 -0500
Message-ID: <405E900C.2070502@redhat.com>
Date: Sun, 21 Mar 2004 23:04:44 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040321
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop O_LARGEFILE from F_GETFL for POSIX compliance
References: <20040322051318.597ad1f9.ak@suse.de>	<20040321213944.2fdb980d.akpm@osdl.org> <20040322071425.3cd57aca.ak@suse.de>
In-Reply-To: <20040322071425.3cd57aca.ak@suse.de>
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> No, because O_LARGEFILE is not part of POSIX :-) (they use open64 etc.)

What are you talking about?  Neither O_LARGEFILE nor open64 is in POSIX.
 But both are in the LFS extensions.

This whole change seems dubious at best.  Who has argued that
O_LARGEFILE mustn't be returned?  I do not agree at all.  If the test
suite checks this the author must defend the position.

I suggest to not make any changes.  It is perfectly OK to define new O_
flags and the open() specification does not require that none of them
must set implicitly.


-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
