Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVDLJxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVDLJxE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 05:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVDLJxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 05:53:04 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:34247 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262087AbVDLJxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 05:53:02 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: New SCM and commit list
References: <1113174621.9517.509.camel@gaston>
	<Pine.LNX.4.58.0504101621200.1267@ppc970.osdl.org>
	<425A10EA.7030607@pobox.com>
	<Pine.LNX.4.58.0504102304050.1267@ppc970.osdl.org>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 12 Apr 2005 10:52:22 +0100
In-Reply-To: <Pine.LNX.4.58.0504102304050.1267@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 10 Apr 2005 23:15:20 -0700 (PDT)")
Message-ID: <tnx64ys8gq1.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> So anything that got modified in just one tree obviously merges to that 
> version. Any file that got modified in two trees will end up just being 
> passed to the "merge" program. See "man merge" and "man diff3". The merger 
> gets to fix up any conflicts by hand.

"merge" does a better job than "diff3" since it can resolve the
conflicts caused by similar changes to a "parent" file (this is
available in both BK and GNU Arch). This is useful when you try to
merge 2 branches that both include a patch which is not under the
revision control. It also solves the conflicts caused by
cherry-picking changes (just need to find the last consecutive common
changeset as the common ancestor).

-- 
Catalin

