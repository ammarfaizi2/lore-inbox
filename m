Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbTDHW7T (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 18:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbTDHW7S (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 18:59:18 -0400
Received: from air-2.osdl.org ([65.172.181.6]:55232 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262509AbTDHW7Q (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 18:59:16 -0400
Date: Tue, 8 Apr 2003 16:10:10 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Martin Hicks <mort@wildopensource.com>
Cc: hpa@zytor.com, pavel@ucw.cz, jes@wildopensource.com,
       linux-kernel@vger.kernel.org, wildos@sgi.com
Subject: Re: [patch] printk subsystems
Message-Id: <20030408161010.25de9e09.rddunlap@osdl.org>
In-Reply-To: <20030408225523.GB3413@bork.org>
References: <20030407201337.GE28468@bork.org>
	<20030408184109.GA226@elf.ucw.cz>
	<m3k7e4ycys.fsf@trained-monkey.org>
	<20030408210251.GA30588@atrey.karlin.mff.cuni.cz>
	<3E933AB2.8020306@zytor.com>
	<20030408215703.GA1538@atrey.karlin.mff.cuni.cz>
	<3E934793.8070801@zytor.com>
	<20030408225523.GB3413@bork.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Apr 2003 18:55:23 -0400 Martin Hicks <mort@wildopensource.com> wrote:

| On Tue, Apr 08, 2003 at 03:05:07PM -0700, H. Peter Anvin wrote:
| > Pavel Machek wrote:
| > > 
| > > Well, #define DEBUG in the driver seems like the way to go. I do not
| > > like "subsystem ID" idea, because subsystems are not really well
| > > defined etc.
| > >
| > 
| > I think that's a non-issue, because it's largely self-defining.  It's
| > basically whatever the developers want them to be, because they're the
| > ones who it needs to make sense to.
| 
| Exactly right.  The worst cases are: 1) developers  assign messages
| to a completely wrong subsystem or 2) don't assign the printk to any
| subsystem, in which case we're in exactly the same situation as we are
| in now.
| 
| > It should, however, be an open set, not a closed set like in syslog.
| 
| I agree.  I'll try to make it as easy as possible to add another
| subsystem.
| 
| I'm going to work on the sysctl interface for this next.

Eek, I have some opinions on this too.

I don't like the #define DEBUG approach.  It's useless for users; it's a
developer debug tool.  It won't allow some support staff to ask users to
enable module debugging (or subsystem debugging) and see what gets printed.

Martin, you are ahead of my schedule, but I was planning to use sysfs
to add a 'debug' flag/file that could be dynamically altered on a per-module
basis.

--
~Randy
