Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272057AbTHKFm2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 01:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272120AbTHKFm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 01:42:28 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:41093 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272057AbTHKFm1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 01:42:27 -0400
Date: Mon, 11 Aug 2003 06:42:09 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Chip Salzenberg <chip@pobox.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davem@redhat.com
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
Message-ID: <20030811054209.GN10446@mail.jlokier.co.uk>
References: <1060488233.780.65.camel@cube> <20030810072945.GA14038@alpha.home.local> <20030811012337.GI24349@perlsupport.com> <20030811020957.GE10446@mail.jlokier.co.uk> <20030811023912.GJ24349@perlsupport.com> <20030811053059.GB28640@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811053059.GB28640@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> So in any case, the !!(x) construct should be valid.

Yes, either of these is fine for pointers and integers alike:

	#define likely(x)	__builtin_expect ((x) != 0, 1)
	#define unlikely(x)	__builtin_expect ((x) != 0, 0)

	#define likely(x)	__builtin_expect (!!(x), 1)
	#define unlikely(x)	__builtin_expect (!!(x), 0)

-- Jamie
