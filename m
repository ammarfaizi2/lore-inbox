Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbSLQTMD>; Tue, 17 Dec 2002 14:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbSLQTMD>; Tue, 17 Dec 2002 14:12:03 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:62900
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S265543AbSLQTLd>; Tue, 17 Dec 2002 14:11:33 -0500
Message-ID: <3DFF78BE.3040201@redhat.com>
Date: Tue, 17 Dec 2002 11:19:26 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021216
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Matti Aarnio <matti.aarnio@zmailer.org>, Hugh Dickins <hugh@veritas.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212171050470.1095-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212171050470.1095-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> In the meantime, I do agree with you that the TLS approach should work
> too, and might be better. It will allow all six arguments to be used if we
> just find a good calling conventions 

If you push out the AT_* patch I'll hack the glibc bits (probably the
TLS variant).  Won't take too  long, you'll get results this afternoon.

What about AMD's instruction?  Is it as flawed as sysenter?  If not and
%ebp is available I really should use the TLS method.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

