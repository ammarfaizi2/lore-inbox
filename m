Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271351AbTHHOAt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 10:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271353AbTHHOAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 10:00:49 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:20879 "HELO
	develer.com") by vger.kernel.org with SMTP id S271351AbTHHOAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 10:00:48 -0400
Message-ID: <3F33AD0B.8020501@develer.com>
Date: Fri, 08 Aug 2003 16:00:43 +0200
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
Subject: Re: Big kernel size increase with gcc 3.4
References: <3F330D46.8020508@develer.com> <20030808024909.GT2712@vitelus.com>
In-Reply-To: <20030808024909.GT2712@vitelus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann wrote:
> On Fri, Aug 08, 2003 at 04:39:02AM +0200, Bernardo Innocenti wrote:
> 
>>- same optimization flags: -m5307 -O2 -fno-strict-aliasing
>>     -fno-common -fno-builtin -fomit-frame-pointer
> 
> You should try -Os if you want to optimize for size.

I did some time ago, and it seems to reduce the code size greatly,
but then I noticed some problems with the memory allocator and
switched back to -O2 for fear that changing the inlining policy
could lead to instability.

I still see those memory allocator problems, so I think I could
safely switch back to -Os now... actually I would recommend it
for all embedded targets.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html



