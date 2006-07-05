Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbWGERSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbWGERSh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 13:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWGERSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 13:18:37 -0400
Received: from canuck.infradead.org ([205.233.218.70]:29834 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S964912AbWGERSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 13:18:36 -0400
Subject: Re: [PATCH 5/5] FRV: Introduce asm-offsets for FRV arch
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, David Howells <dhowells@redhat.com>,
       akpm@osdl.org, bernds_cb1@t-online.de, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0607050956020.12404@g5.osdl.org>
References: <20060705132409.31510.22698.stgit@warthog.cambridge.redhat.com>
	 <20060705132419.31510.92219.stgit@warthog.cambridge.redhat.com>
	 <20060705144138.GA26545@mars.ravnborg.org>
	 <1152117585.2987.21.camel@pmac.infradead.org>
	 <Pine.LNX.4.64.0607050956020.12404@g5.osdl.org>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Jul 2006 18:18:24 +0100
Message-Id: <1152119904.2987.30.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-05 at 10:03 -0700, Linus Torvalds wrote:
> Hey, if you are willing to add some manual redirection to your gitweb 
> setup, you could _probably_ do something like the appended..
> 
> (This is totally untested, but you get the idea - teach gitweb to export 
> a "git_redirect" file at the top of the repo name, and teach "git fetch" 
> to look if that exists and use another repo if so) 

That'll turn this URL: 
 http://git.infradead.org/?p=users/dwmw2/killconfig.h.git
into
 http://git.infradead.org/?p=users/dwmw2/killconfig.h.git/git_redirect

It's going to be easier to do the gitweb side if we change it to append
';a=git_redirect' instead. In fact, we could probably make the
conditional on the URL containing a ?p= argument which makes it
(reasonably) obvious that it's a gitweb URL, and _replace_ any 'a='
argument in the URL rather than just appending it naïvely.

I'll play with that later this evening.

-- 
dwmw2

