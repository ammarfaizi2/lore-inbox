Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751760AbWHSQD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbWHSQD0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 12:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbWHSQD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 12:03:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65421 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751760AbWHSQDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 12:03:25 -0400
Date: Sat, 19 Aug 2006 09:03:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>
Subject: Re: [PATCH 4/7] proc: Make the generation of the self symlink table
 driven.
Message-Id: <20060819090322.1b991a33.akpm@osdl.org>
In-Reply-To: <m1psexum92.fsf@ebiederm.dsl.xmission.com>
References: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
	<1155665132774-git-send-email-ebiederm@xmission.com>
	<20060819010656.e169c3b7.akpm@osdl.org>
	<m1psexum92.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2006 03:07:37 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Andrew Morton <akpm@osdl.org> writes:
> 
> > On Tue, 15 Aug 2006 12:05:27 -0600
> > "Eric W. Biederman" <ebiederm@xmission.com> wrote:
> >
> >> By not rolling our own inode we get a little more code reuse,
> >> and things get a little simpler and we don't have special
> >> cases to contend with later.
> >
> > On a standard FC5 install (which has selinux enabled) things get very ugly.
> >
> > udev: MAKEDEV: mkdir: file exists
> >
> > followed by a stream of udev errors of various sorts and then an infinite
> > loop of auditd complaints about klogd and "/" and tmpfs.  Nothing makes it
> > to logs because klogd itself is failing.
> 
> I'm not feeling very generous today.  I'm wondering what selinux bug
> I have found now.  Without selinux everything is fine on FC5.
> 
> Any chance of a search through that patchset to see which patch selinux
> trips on?
> 

This one.  "PATCH 4/7] proc: Make the generation of the self symlink table driven."
