Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVCQUdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVCQUdo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 15:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVCQUdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 15:33:44 -0500
Received: from peabody.ximian.com ([130.57.169.10]:42722 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261154AbVCQUdl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 15:33:41 -0500
Subject: Re: linux: detect application crash
From: Robert Love <rml@novell.com>
To: Allison <fireflyblue@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17d7988050317122755d6958b@mail.gmail.com>
References: <17d7988050317122755d6958b@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 17 Mar 2005 15:33:39 -0500
Message-Id: <1111091619.28562.141.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-17 at 15:27 -0500, Allison wrote:

> Several times when I worked with Windows, I have had a scenario when I
> am editing a file and saved some time ago and then the application
> crashes and I lose all recent data.
> 
> Can the operating system detect all application crashes ? If so, why
> can't the OS save the user data to disk before the application quits ?
> 
> How does this work in Linux. I was curious if such a functionality
> already exists in Linux. If not, what are the issues involved in
> implementing this functionality.

It is hard to just wholesale "save the user's data" because the
application is crashing, things are inconsistent, something is broken,
etc.

But it is possible to dump all memory (a core dump).  Linux does this
now.

It is also possible to catch a segfault and handle it.  Various GUI
libraries do this.  For example, GNOME handles segfaults, presenting the
user with various options (send bug report, restart application, etc).

The best bet, from an application developer's standpoint, is to just not
crash.  Second best, save early and save often.

	Robert Love


