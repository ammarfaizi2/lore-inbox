Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbUEJShk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUEJShk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 14:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbUEJShk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 14:37:40 -0400
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:15799 "EHLO kiwi.cs.ucla.edu")
	by vger.kernel.org with ESMTP id S261181AbUEJShj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 14:37:39 -0400
To: Jon Oberheide <jon@focalhost.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, bug-patch@gnu.org,
       bug-gnu-utils@gnu.org
Subject: Re: [PATCH] [RFC] adding support for .patches and /proc/patches.gz
References: <1084157289.7867.0.camel@latitude>
From: Paul Eggert <eggert@CS.UCLA.EDU>
Date: Mon, 10 May 2004 11:37:34 -0700
In-Reply-To: <1084157289.7867.0.camel@latitude> (Jon Oberheide's message of
 "Sun, 09 May 2004 22:48:09 -0400")
Message-ID: <87oeowb029.fsf@penguin.cs.ucla.edu>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Oberheide <jon@focalhost.com> writes:

> I'm CC'ing this to the GNU patch maintainers.  Hopefully they will have
> some input.

As I understand it, Solution 4 is an incompatible change to 'patch'
which would cause 'patch' to not conform to POSIX, the LSB, or to
widespread existing practice.  That's a pretty serious step, and I'm
not sure it's worth the aggravation.

Solution 3 would be to add an option to 'patch' to cause it to log the
patches into a file.  The basic idea seems like a worthwhile
improvement to 'patch', though (as you mention) it's more of a hassle
for users to remember the option.

Perhaps there's a better way to address the problem in a way that
maintains compatibility while still satisfying your needs.  For example,
if the kernel patches all contained a line like this at the start:

Patch-log: .patches

then 'patch' could log all the changes into the named file.  This
would conform to POSIX.
