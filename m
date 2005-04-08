Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbVDHLmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbVDHLmg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 07:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbVDHLmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 07:42:36 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:18835 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262744AbVDHLme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 07:42:34 -0400
To: Chris Wedgwood <cw@f00f.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	<20050408041341.GA8720@taniwha.stupidest.org>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Fri, 08 Apr 2005 12:42:19 +0100
Message-ID: <tnxk6ndtrz8.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> wrote:
> I'm playing with monotone right now.  Superficially it looks like it
> has tons of gee-whiz neato stuff...  however, it's *agonizingly* slow.
> I mean glacial.  A heavily sedated sloth with no legs is probably
> faster.

I tried some time ago to import the BKCVS revisions since Linux 2.6.9
into a monotone-0.16 repository. I later tried to upgrade the database
(repository) to monotone version 0.17. The result - converting ~3500
revisions would have taken more than *one year*, fact confirmed by the
monotone developers. The bottleneck seemed to be the big size of the
manifest (which stores the file names and the corresponding SHA1
values) and all the validation performed when converting. The
solution, unsafe, is to disable the revision checks in monotone but
you can end up with an inconsistent repository (haven't tried this).

-- 
Catalin

