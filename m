Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275358AbTHMUSe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 16:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275363AbTHMUSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 16:18:34 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:521 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S275358AbTHMUSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 16:18:32 -0400
Date: Wed, 13 Aug 2003 22:18:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: George Anzinger <george@mvista.com>
Cc: Thomas Schlichter <schlicht@uni-mannheim.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test3-mm1
Message-ID: <20030813201829.GA15012@mars.ravnborg.org>
Mail-Followup-To: George Anzinger <george@mvista.com>,
	Thomas Schlichter <schlicht@uni-mannheim.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030809203943.3b925a0e.akpm@osdl.org> <200308101941.33530.schlicht@uni-mannheim.de> <3F37DFDC.6080308@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F37DFDC.6080308@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 11:26:36AM -0700, George Anzinger wrote:
> >that patch sets DEBUG_INFO to y by default, even if whether DEBUG_KERNEL 
> >nor KGDB is enabled. The attached patch changes this to enable DEBUG_INFO 
> >by default only if KGDB is enabled.
> 
> Looks good to me, but.... just what does this turn on?  Its been a 
> long time and me thinks a wee comment here would help me remember next 
> time.

DEBUG_INFO add "-g" to CFLAGS.
Main reason to introduce this was that many architectures always use
"-g", so a config option seemed more appropriate.
I do not agree that this should be dependent on KGDB.
To my knowledge -g is useful also without using kgdb.

	Sam
