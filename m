Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270822AbTHKBYM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 21:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270828AbTHKBYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 21:24:12 -0400
Received: from tandu.perlsupport.com ([66.220.6.226]:29825 "EHLO
	tandu.perlsupport.com") by vger.kernel.org with ESMTP
	id S270822AbTHKBYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 21:24:12 -0400
Date: Sun, 10 Aug 2003 21:23:37 -0400
From: Chip Salzenberg <chip@pobox.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davem@redhat.com, jamie@shareable.org
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
Message-ID: <20030811012337.GI24349@perlsupport.com>
References: <1060488233.780.65.camel@cube> <20030810072945.GA14038@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030810072945.GA14038@alpha.home.local>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Willy Tarreau:
>   likely => __builtin_expect(!(x), 0)
> unlikely => __builtin_expect((x), 0)

Well, I'm not sure about the polarity, but that unlikely() macro isn't
good -- it the same old problem that first prompted my message, namely
that it's nonportable when (x) has a pointer type.
-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K
