Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317864AbSGVW1C>; Mon, 22 Jul 2002 18:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317866AbSGVW1C>; Mon, 22 Jul 2002 18:27:02 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:32530 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317864AbSGVW1B>;
	Mon, 22 Jul 2002 18:27:01 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207222229.g6MMTUZ282057@saturn.cs.uml.edu>
Subject: Re: [PATCH] 2.5.27 smbiod
To: martin@dalecki.de
Date: Mon, 22 Jul 2002 18:29:30 -0400 (EDT)
Cc: torvalds@transmeta.com (Linus Torvalds),
       linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3D3BE2B5.9010807@evision.ag> from "Marcin Dalecki" at Jul 22, 2002 12:47:17 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcin Dalecki writes:

> Fix label at block end warning - don't write "assembler code".
...
>  	if (server->state != CONN_VALID)
> -		goto out;
> +		return;
...
> -
> -out:
>  }


Assembler? No, that would be Pascal. Many would argue
that a return out of the middle is as ugly as a goto.

Maybe it doesn't matter, and maybe you did actually
improve the code generation, but there's an obvious
way to ditch the warning without changing so much.
Note the semicolon:

out:;
}
