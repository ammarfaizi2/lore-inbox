Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312277AbSDJA3V>; Tue, 9 Apr 2002 20:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312294AbSDJA3U>; Tue, 9 Apr 2002 20:29:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:58062 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S312277AbSDJA3U>; Tue, 9 Apr 2002 20:29:20 -0400
Subject: Re: Event logging vs enhancing printk
From: Brian Beattie <alchemy@us.ibm.com>
To: Brian Beattie <alchemy@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1018391340.7923.40.camel@w-beattie1>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 09 Apr 2002 17:29:17 -0700
Message-Id: <1018398557.7923.55.camel@w-beattie1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-09 at 15:28, Brian Beattie wrote:

> > 
> > > I would prefer to see effort expended on fixing printk/klogd...off the
> > > top of my head:
> > > 
> > > - make printk a macro that prepends file/function/line to the message.

I take this one back, file/function/line does not add any useful
information to the vast majority of the printk messages, but adds a
great deal of bloat to the logs.

I think establishing some guide lines for log message content and
format, and updating some of the more critical parts of the kernel would
do a lot more to provide the kind of logging that is being called for. 
It may well be that this needs to be done in a way that can be
controlled by a compile time option so the old format can be had by
those who prefer it, and the new by those who feel the need.

The basic problem, in my experience, is not the logging mechanisims, but
that the correct messages are not produced under the correct
conditions.  This is a problem that can only be fixed by adding the
appropriate calls to whatever logging mechanism is available.

That is to say that, not all conditions that are critical are logged in
a way that provides the information to determine, after the fact, what
happened.  A new logging mechanism will not fix that.

