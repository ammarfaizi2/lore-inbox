Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267402AbTGVCpd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 22:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268013AbTGVCpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 22:45:33 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:23460 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S267402AbTGVCpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 22:45:32 -0400
Date: Mon, 21 Jul 2003 21:31:44 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: RAMON_GARCIA_F <RAMON_GARCIA_F@terra.es>, linux-kernel@vger.kernel.org
Subject: Re: Suggestion for a new system call: convert file handle to a cookie for transfering file handles between processes.)
Message-ID: <20030721213144.O639@nightmaster.csn.tu-chemnitz.de>
References: <5df3060bad.60bad5df30@teleline.es> <20030721172656.GA32597@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030721172656.GA32597@delft.aura.cs.cmu.edu>; from jaharkes@cs.cmu.edu on Mon, Jul 21, 2003 at 01:27:06PM -0400
X-Spam-Score: -5.0 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19enOE-0004Df-00*K3.9BSo9vcM*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 01:27:06PM -0400, Jan Harkes wrote:
> - Refcounting issues, a rogue application can quickle use up kernel
>   resources by requesting thousands of cookies, he isn't even limited by
>   per-process resource limits, as it is possible to open a file, grab a
>   cookie, and close the file. The only 'solution' you have is a timeout
>   on the cookie, possibly this could be extended by some scheme where
>   cookies are dropped more agressivly. But any such solution will either
>   not be sufficient to protect the system from resource exhaustion or
>   provide the opportunity for denial of service attacks.

Best of all: How big you make the number, doesn't matter: You can
always guess such numbers as a local attacker. If not now, then
in some years (want to recompile all existing applications then?).

cmsg(SCM_RIGHTS) is the much better solution, if you really have
processes, which are neither a sibling nor a parent/child
relationship.

And it's also ugly enough ;-)

Regards

Ingo Oeser
