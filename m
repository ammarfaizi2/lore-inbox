Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319085AbSHFOAN>; Tue, 6 Aug 2002 10:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319086AbSHFOAN>; Tue, 6 Aug 2002 10:00:13 -0400
Received: from daimi.au.dk ([130.225.16.1]:58508 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S319085AbSHFOAM>;
	Tue, 6 Aug 2002 10:00:12 -0400
Message-ID: <3D4FD736.DA443B4B@daimi.au.dk>
Date: Tue, 06 Aug 2002 16:03:34 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: manfred@colorfullife.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] Warn users about machines with non-working WP bit
References: <3D4F942D.7020100@colorfullife.com> <20020806.022813.27560736.davem@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> verify_area() checks aren't enough, consider a threaded application
> calling mprotect() while the copy is in progress.

Couldn't we just freeze all other processes with the same mm while
a copy_to_user is in progress?

Of course this should only be done if CONFIG_X86_WP_WORKS_OK is
not enabled, so systems with a working wp doesn't have to take a
performance hit.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
