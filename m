Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263960AbRFVAcv>; Thu, 21 Jun 2001 20:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264331AbRFVAcl>; Thu, 21 Jun 2001 20:32:41 -0400
Received: from mail2.ameuro.de ([62.208.90.8]:62725 "EHLO mail2.ameuro.de")
	by vger.kernel.org with ESMTP id <S263960AbRFVAc3>;
	Thu, 21 Jun 2001 20:32:29 -0400
Message-ID: <3B3291CE.7BAF5BC3@alarsen.net>
Date: Fri, 22 Jun 2001 02:30:48 +0200
From: Anders Larsen <anders@alarsen.net>
Organization: syst.eng. A.Larsen (http://www.alarsen.net/)
MIME-Version: 1.0
To: "Richard B. Johnson" <root@chaos.analogic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
In-Reply-To: <Pine.LNX.3.95.1010621193107.6383A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> QNX does not have any difference between user-space and kernel space.
> It's not paged-virtual. It's just one big sheet of address space
> with no memory protection (everything is shared). All procedures
> to be executed are known at compile time.

That's completely, utterly untrue.
QNX does indeed sport paged-virtual memory with memory protection;
(although QNX4 does not support swap).

User-mode interrupts are standard procedure; the deadlock problems
Alan has mentioned do not apply, since any running process is
always resident in memory.
Shared regions have to be explicitly created; access is *not* open
to anybody.

Nothing has to be known at "compile time"; QNX is a full-featured
OS with dynamic loading.

> Therefore, any piece of code can do anything it wants including
> handling hardware directly.

Again not true; only privileged processes can enter kernel mode
to execute port I/O instructions directly.

cheers
Anders
-- 
"In theory there is no difference between theory and practice.
 In practice there is." - Yogi Berra
