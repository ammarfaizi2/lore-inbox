Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262993AbVALBmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbVALBmr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 20:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbVALBmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 20:42:47 -0500
Received: from mail.joq.us ([67.65.12.105]:58534 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262993AbVALBmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 20:42:45 -0500
To: Chris Wright <chrisw@osdl.org>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Matt Mackall <mpm@selenic.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050111214152.GA17943@devserv.devel.redhat.com>
	<200501112251.j0BMp9iZ006964@localhost.localdomain>
	<20050111150556.S10567@build.pdx.osdl.net>
From: "Jack O'Quin" <joq@io.com>
Date: Tue, 11 Jan 2005 19:43:29 -0600
In-Reply-To: <20050111150556.S10567@build.pdx.osdl.net> (Chris Wright's
 message of "Tue, 11 Jan 2005 15:05:56 -0800")
Message-ID: <87y8ezzake.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> writes:

> * Paul Davis (paul@linuxaudiosystems.com) wrote:
>> >On Tue, Jan 11, 2005 at 04:38:14PM -0500, Lee Revell wrote:
>> >> Yes but a bug in an app running as root can trash the filesystem.  The
>> >> worst you can do with RT privileges is lock up the machine.
>> >
>> >several filesystem and IO threads run at prio -10 but not RT.
>> >That makes me a bit less sure of your statement....
>> 
>> Its completely orthogonal. Lee didn't say "tasks running without RT
>> can't mess up filesystems". He said "tasks running as root can trash
>> the filesystem" and "tasks running as RT can lock up the
>> machine". obviously, the intersection point (a root, RT task) is
>> double trouble.
>
> This is straying from the core issue...  But, Arjan's saying that an RT
> (non-root) task could trash the filesystem if it deadlocks the machine
> (because those important fs and IO threads don't run).

Lexicographic ambiguity: Lee and Paul are using "trash" for things
like installing a hidden suid root shell or co-opting sendmail into an
open spam relay.  Arjan just means crashing the system which forces
reboot to run fsck.
-- 
  joq
