Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBEVrj>; Mon, 5 Feb 2001 16:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129031AbRBEVr3>; Mon, 5 Feb 2001 16:47:29 -0500
Received: from equator.dsl.speakeasy.net ([216.254.12.202]:47088 "EHLO
	gatekeeper.equator.com") by vger.kernel.org with ESMTP
	id <S129027AbRBEVrL>; Mon, 5 Feb 2001 16:47:11 -0500
To: linux-kernel@vger.kernel.org
Subject: make problem: -Dfoo='"bar"' and FILES_FLAGS_CHANGED in .flags 
From: Kevin Hilman <khilman@equator.com>
Organization: Equator Technologies
Date: 05 Feb 2001 13:47:10 -0800
Message-ID: <r24ry82469.fsf@bobdog.equator.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When using -Dfoo='"bar"' in CFLAGS, it ends up as -Dfoo=bar in the
.flags file.  This difference causes the FILES_FLAGS_CHANGED to get
set for any files that have that in their CFLAGS, and therefore they
are always remade.

I'm not sure where the right place to change this is, but it looks
like the .c.o rule in Rules.make is where the .flags files are
generated.

-- 
Kevin Hilman
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
