Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSGSTWt>; Fri, 19 Jul 2002 15:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315708AbSGSTWt>; Fri, 19 Jul 2002 15:22:49 -0400
Received: from gate.in-addr.de ([212.8.193.158]:51727 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S315717AbSGSTVy>;
	Fri, 19 Jul 2002 15:21:54 -0400
Date: Fri, 19 Jul 2002 21:25:24 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: "Patrick J. LoPresti" <patl@curl.com>,
       Joseph Malicki <jmalicki@starbak.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: close return value
Message-ID: <20020719192524.GY12420@marowsky-bree.de>
References: <200207182347.g6INlcl47289@saturn.cs.uml.edu> <s5gsn2fr922.fsf@egghead.curl.com> <015401c22f40$c4471380$da5b903f@starbak.net> <s5gvg7bmu43.fsf@egghead.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5gvg7bmu43.fsf@egghead.curl.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-07-19T14:48:44,
   "Patrick J. LoPresti" <patl@curl.com> said:

> Of course, checking errors in order to handle them sanely is a good
> thing.  Nobody is arguing that.  What I am arguing is that failing to
> check errors when they can "never happen" is wrong.

Actually, checking for _all_ even remotely possible and checkable error
conditions (if the check doesn't incur an intolerable overhead) is a very very
important requirement for writing high quality code; even if it isn't "fault
tolerant" (because it may not know how to recover, as with the ill-defined
semantics of close() returning error), it will at least be "fail-fast"; giving
an error message close to the cause and terminate in a co-ordinated manner
before corrupting data.

It troubles me deeply that some people hacking on the Linux kernel do not
consider this a good thing.

And with that, I conclude my point and step out of the discussion for good.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

