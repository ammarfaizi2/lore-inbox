Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271760AbRIEHDo>; Wed, 5 Sep 2001 03:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271763AbRIEHDe>; Wed, 5 Sep 2001 03:03:34 -0400
Received: from mail.webmaster.com ([216.152.64.131]:48026 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S271760AbRIEHDU>; Wed, 5 Sep 2001 03:03:20 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Aaron Lehmann" <aaronl@vitelus.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.9-ac6
Date: Wed, 5 Sep 2001 00:03:39 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMMEBMDLAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <20010904225638.B9241@vitelus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, Sep 04, 2001 at 10:16:15PM -0700, David Schwartz wrote:
> > 	Yes, but even if the module is GPL'd, the module could
> > still cost $1,000
> > and you're not entitled to the source if you didn't buy the
> > module. If what
> > you want is "source code is available to the general public",
> > then that can
> > be true or false for both GPL'd and non-GPL'd modules.

> WTF.
>
> You understand that the GPL would allow the reporter to include the
> module source, right? It also doesn't really matter if it doesn't come
> with source because someone using the binary has a legal right to ask
> for source.

	Sure, they have the legal right to ask for the source, but they might or
might not do so and might or might not make the source available to the
reporter.

	I think, perhaps, the logic should be that a module shouldn't taint the
kernel if:

	1) The user built the module from source on that machine, OR

	2) The module source is freely available without restriction

	But maybe I'm still not understanding what tainting is supposed to mean.
Note that both '1' and '2' are orthogonal to whether the module is GPL'd or
not.

	'2' would require a copyrighted tag, so that legal action could be taken
against those who misuse it (not that it's likely, considering it doesn't
really give any new capability and such deception would be rapidly
detected). I'm not sure if '1' is doable. Perhaps put a 'random' tag in the
config file and include that tag when the module is compiled. If the tags
match, then don't taint. This would catch config changes without module
rebuilds too.

	I think it's worth the effort to get this right to avoid sending the
message that if you use anything that's not GPL'd, the Linux community won't
help you. (Not that that's really what's happening, but it may look that
way.)

	DS

