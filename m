Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131933AbQKRXq3>; Sat, 18 Nov 2000 18:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132012AbQKRXqT>; Sat, 18 Nov 2000 18:46:19 -0500
Received: from 3dyn88.com21.casema.net ([212.64.94.88]:40976 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S131933AbQKRXqF>;
	Sat, 18 Nov 2000 18:46:05 -0500
Date: Sat, 18 Nov 2000 23:53:52 +0100
From: Jasper Spaans <spaans@delft.corps.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] raid5 link error? (was [PATCH] raid5 fix after xor.c cleanup)
Message-ID: <20001118235352.D2226@spaans.ds9a.nl>
In-Reply-To: <20001117234144.A14461@spaans.ds9a.nl> <20001118123536.A5674@spaans.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001118123536.A5674@spaans.ds9a.nl>; from jasper@spaans.ds9a.nl on Sat, Nov 18, 2000 at 12:35:36PM +0100
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2000 C. Jasper Spaans - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2000 at 12:35:36PM +0100, Jasper Spaans wrote:

> Hmm, next time I'll need to eat my own dogfood -- this patch doesn't work,
> it only compiles. Don't use it.

It seems to me the original code was correct, but the linking isn't in the
right order and the initcalls are in the wrong order (ie,
raid5.c::raid5_init() is being called before xor.c::calibrate_xor_block() --
any linking gurus out there who can help me out on this one?

Feeling a bit of a schizo, but getting used to my brown paper bag,

Regards
-- 
  Q_.        Jasper Spaans  <mailto:jspaans@mediakabel.nl>        -o)
 `~\         Conditional Access/DVB-C/OpenTV/Unix-adviseur        /\\
Mr /\                                                            _\_v
Zap     Een ongezellig dure consultant nodig? Mail sales@insultant.nl
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
