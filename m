Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751509AbWB0RTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbWB0RTi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 12:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWB0RTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 12:19:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37790 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751510AbWB0RTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 12:19:37 -0500
Subject: Re: [Patch 2/4] Basic reorder infrastructure
From: Arjan van de Ven <arjan@infradead.org>
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org, ak@suse.de
In-Reply-To: <49447.194.237.142.21.1141057876.squirrel@194.237.142.21>
References: <1141053825.2992.125.camel@laptopd505.fenrus.org>
	 <1141054054.2992.130.camel@laptopd505.fenrus.org>
	 <49447.194.237.142.21.1141057876.squirrel@194.237.142.21>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 18:19:34 +0100
Message-Id: <1141060775.2992.149.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 17:31 +0100, sam@ravnborg.org wrote:
> > This patch puts the infrastructure in place to allow for a reordering of
> > functions based inside the vmlinux.
> 
> Can we make this general instead of x86_64 only?
> Then we can use Kconfig to enable it for the architectures where we want it.

Actually Linus had pretty good arguments to make this per-architecture:
the list will be different on each architecture.

(eg my first patch had it more generic; but Linus asked it to be per
arch, and I agree with the reasons he gave)

Also I doubt it can be enabled "blindly" for all architectures; I expect
more to need hacks similar to the x86_64 entry.S fix before it can
work...


