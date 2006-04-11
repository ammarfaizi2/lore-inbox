Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWDKLaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWDKLaP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWDKLaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:30:14 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19333 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750758AbWDKLaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:30:13 -0400
To: "Prasanna Meda" <mlp@google.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Comment about proc-dont-lock-task_structs-indefinitely.patch
References: <608a53b0604101242v4778af80ybaf639c38cc00587@mail.google.com>
	<608a53b0604110348g22445b00u5ef57286eb230d58@mail.google.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 11 Apr 2006 05:28:52 -0600
In-Reply-To: <608a53b0604110348g22445b00u5ef57286eb230d58@mail.google.com> (Prasanna
 Meda's message of "Tue, 11 Apr 2006 16:18:48 +0530")
Message-ID: <m1ek04bbbf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Prasanna Meda" <mlp@google.com> writes:

> On 4/11/06, Prasanna Meda <mlp@google.com> wrote:
>
>>
>> The task decrement problem is fixed, but I think we have two more
>> problems in the following patch segment.
>>
>
> I think you agreed with the first problem. And the second problem is,
> show_map_internal is still treating m->private as task_struct instead
> of  proc_maps_private.

Sorry my brain has been off thinking about a subtle
bug accidentally introduced in 2.6.17-rc1.

You are absolutely right.  Somehow I missed the
fact that show_map_internal was using m->private.
Because get_gate_vma doesn't actually use it's argument
no bad behavior will result but that could change.

As for the seek case you may be right.
I have a cold that is beating on me, and I need to take a nap.

I remember looking at that closely and not seeing a problem,
but I have made mistakes before, and I'm not certain I recall
the seek case.


Eric




