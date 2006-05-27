Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWE0QNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWE0QNX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 12:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWE0QNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 12:13:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:451 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964827AbWE0QNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 12:13:21 -0400
Date: Sat, 27 May 2006 09:13:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
cc: Jeff Garzik <jeff@garzik.org>, Git Mailing List <git@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SCRIPT] chomp: trim trailing whitespace
In-Reply-To: <46a038f90605270828u7842ea48hda07331388694db2@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0605270905190.5623@g5.osdl.org>
References: <4477B905.9090806@garzik.org> <46a038f90605270828u7842ea48hda07331388694db2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 May 2006, Martin Langhoff wrote:
>
> I love perl golf for this kind of stuff... but git-stripspace is part
> of git already. Even then, I tend to do it with perl -pi -e ''
> constructs ;-)

Well, git-stripspace actually does something slightly differently, in that 
it also removes extraneous all-whitespace lines from the beginning, the 
end, and the middle (in the middle, the rule is: two or more empty lines 
are collapsed into one).

Ie it's a total hack for parsing just commit messages (and it is in C, 
because I can personally write 25 lines of C in about a millionth of the 
time I can write 3 lines of perl).

		Linus
