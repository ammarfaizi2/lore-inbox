Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292081AbSBOKCW>; Fri, 15 Feb 2002 05:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292082AbSBOKCM>; Fri, 15 Feb 2002 05:02:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2322 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292081AbSBOKBw>;
	Fri, 15 Feb 2002 05:01:52 -0500
Message-ID: <3C6CDC8E.A16D39D7@mandrakesoft.com>
Date: Fri, 15 Feb 2002 05:01:50 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@transmeta.com, davidm@hpl.hp.com,
        "David S. Miller" <davem@redhat.com>, anton@samba.org,
        linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] move task_struct allocation to arch
In-Reply-To: <12214.1013706194@warthog.cambridge.redhat.com> <3C6CDB4D.D072A7B4@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Your patch would be ok IMHO if you additionally changed the arches to
> include task struct inside struct thread_info, getting things back down
> to a single allocation for thread_info+task_struct, with 'current' once
> again being a constant offset from the beginning of thread_info.  [this
> might require resurrecting the old patches to move task struct
> definitions out of sched.h proper]

Actually, you don't really need the definition of task_struct, if
include dependencies get really hairy... you really only need the size
of the task struct.

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
