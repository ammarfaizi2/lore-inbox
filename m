Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265701AbRGFBp2>; Thu, 5 Jul 2001 21:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265696AbRGFBpS>; Thu, 5 Jul 2001 21:45:18 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:58374 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S264942AbRGFBpJ>;
	Thu, 5 Jul 2001 21:45:09 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200107060145.f661j5v74941@saturn.cs.uml.edu>
Subject: Re: [PATCH] more SAK stuff
To: landley@webofficenow.com
Date: Thu, 5 Jul 2001 21:45:04 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01070318005005.06999@localhost.localdomain> from "Rob Landley" at Jul 03, 2001 06:00:50 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley writes:

> Off the top of my head, fun things you can't do suid root:
...
> ps  (What the...?  Worked in Red Hat 7, but not in suse 7.1.
> Huh?  "suid-to  apache ps ax" works fine, though...)

The ps command used to require setuid root. People would set the
bit by habit.

> I keep bumping into more of these all the time.  Often it's fun
> little warnings "you shouldn't have the suid bit on this
> executable", which is frustrating 'cause I haven't GOT the suid bit
> on that executable, it inherited it from its parent process, which
> DOES explicitly set the $PATH and blank most of the environment
> variables and other fun stuff...)

Oh, cry me a river. You can set the RUID, EUID, SUID, and FUID
in that same parent process or after you fork().

Since you didn't set all the UID values, I have to wonder what
else you forgot to do. Maybe you shouldn't be messing with
setuid programming.
