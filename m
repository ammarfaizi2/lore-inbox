Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271743AbTHRM6l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 08:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271744AbTHRM6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 08:58:41 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:5250
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271743AbTHRM6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 08:58:39 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Max Hailperin <max@gustavus.edu>
Subject: Re: [RFC] Re: Blender profiling-1 O16.2int
Date: Mon, 18 Aug 2003 23:05:19 +1000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <20030818110001.6564.64238.Mailman@lists.us.dell.com> <200308181252.h7ICqZh8003767@mccormic.mcs.gac.edu>
In-Reply-To: <200308181252.h7ICqZh8003767@mccormic.mcs.gac.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308182305.19339.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003 22:52, Max Hailperin wrote:
>    ... I do have some ideas about how to progress with this (some Mike
>    has suggested to me previously), but so far most of them involve
>    some detriment to the interactive performance on other apps. So I'm
>    appealing to others for ideas.

> I suggest you put a small limit on the number of times that a task can
> be requeued onto the active array before it needs to go to the expired
> array.  -max

Thanks; I appreciate your comments. That's what's currently in place at the 
moment, and the lower the number of requeues the less it starves... 
Unfortunately, this also means that the shorter it takes a real interactive 
task to expire as well. This is the theme I'm currently working on though, as 
the starver gets rescheduled ahead of anything else and I've developed a way 
of letting other tasks sneak in ahead if it starts doing that. It needs more 
tuning but seems to work so far.

Cheers,
Con

