Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268535AbUJECP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268535AbUJECP0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 22:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268735AbUJECP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 22:15:26 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:24063 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S268535AbUJECPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 22:15:24 -0400
Date: Mon, 4 Oct 2004 19:15:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 2.6.9-rc3] Fix 'htmldocs' and friends with O=
Message-ID: <20041005021523.GE32692@smtp.west.cox.net>
References: <20041004233958.GD32692@smtp.west.cox.net> <20041005002814.GA32087@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041005002814.GA32087@thundrix.ch>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 02:28:14AM +0200, Tonnerre wrote:

> Salut,
> 
> On Mon, Oct 04, 2004 at 04:39:58PM -0700, Tom Rini wrote:
> > --- linux-2.6.9-rc3.orig/scripts/kernel-doc
> > +++ linux-2.6.9-rc3/scripts/kernel-doc
> > @@ -1531,7 +1531,7 @@ sub process_state3_type($$) { 
> >  }
> >  
> >  sub process_file($) {
> > -    my ($file) = @_;
> > +    my ($file) = "$ENV{'SRCTREE'}@_";
> >      my $identifier;
> >      my $func;
> >      my $initial_section_counter = $section_counter;
> 
> From performance/memory footprint standpoint it might be better to use
> the dot operator here for concatenation.

I'm not a perl person, so if this makes sense to you Sam (or Andrew, if
you've taken this...) please update.  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
