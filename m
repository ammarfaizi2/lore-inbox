Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274851AbRIUVyH>; Fri, 21 Sep 2001 17:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274852AbRIUVx4>; Fri, 21 Sep 2001 17:53:56 -0400
Received: from [194.213.32.137] ([194.213.32.137]:12548 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S274851AbRIUVxo>;
	Fri, 21 Sep 2001 17:53:44 -0400
Message-ID: <20010921235025.A308@bug.ucw.cz>
Date: Fri, 21 Sep 2001 23:50:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: swsusp@lister.fornax.hu,
        ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: New swsusp patch + Q: how to free memory?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here's new swsusp patch. It no longer adds signals (breaking ABI), and
it now should work okay with journaling filesystems. Hardware state
restore is (mostly) not done -- that's task for someone else, like
ACPI.

Last big remaining problem is "how to free memory". What's currently
in swsusp patch just does no work. Any advice wanted. Don't try with
hard real-time tasks. (Funny question: should suspend be supported
with such beasts around? ;-). Oh and we have some by-design problems
with network. Maybe some packets will be sent twice.

I wanted to free memory by eat_memory() followed by free_memory(), but
that's big no-no from context swsusp is using.
								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
