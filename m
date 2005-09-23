Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbVIWPKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbVIWPKc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 11:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVIWPKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 11:10:32 -0400
Received: from nevyn.them.org ([66.93.172.17]:27288 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1751077AbVIWPKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 11:10:31 -0400
Date: Fri, 23 Sep 2005 11:10:17 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Laurent Vivier <LaurentVivier@wanadoo.fr>, linux-kernel@vger.kernel.org,
       Jeff Dike <jdike@addtoit.com>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: Re: PTRACE_SYSEMU numbering
Message-ID: <20050923151017.GA2558@nevyn.them.org>
Mail-Followup-To: Blaisorblade <blaisorblade@yahoo.it>,
	Laurent Vivier <LaurentVivier@wanadoo.fr>,
	linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
	Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>,
	Bodo Stroesser <bstroesser@fujitsu-siemens.com>
References: <20050921172550.GA10332@nevyn.them.org> <4D3DE86B-EDE9-494E-A935-A6CE9CFF1134@wanadoo.fr> <200509222146.39172.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509222146.39172.blaisorblade@yahoo.it>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 09:46:38PM +0200, Blaisorblade wrote:
> The fix is easy, IMHO, and not even urgent. It suffices to move PTRACE_SYSEMU 
> def from <linux/ptrace.h> to <asm-i386/ptrace.h>, and we didn't do that yet 
> for laziness only. There's no architecture that I know of, apart i386, which 
> implements SYSEMU (except maybe s390, but that isn't public).

Please either renumber it to something above 0x4200, or make it i386
private.  If you intend for other architectures to implement it in the
future, renumbering it would be better.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
