Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUJPS4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUJPS4M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 14:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUJPS4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 14:56:11 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:43618 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261234AbUJPS4A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 14:56:00 -0400
Date: Sat, 16 Oct 2004 22:56:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Tom Rini <trini@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 2.6.9-rc3] Fix 'htmldocs' and friends with O=
Message-ID: <20041016205600.GA8306@mars.ravnborg.org>
Mail-Followup-To: Tonnerre <tonnerre@thundrix.ch>,
	Tom Rini <trini@kernel.crashing.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>
References: <20041004233958.GD32692@smtp.west.cox.net> <20041005002814.GA32087@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041005002814.GA32087@thundrix.ch>
User-Agent: Mutt/1.5.6i
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

For this usage I prefer readability for us who are not familiar with perl.
For me a '.' is used as thousand separator and end of line. No
usage for concatenation seems intuitive.
So I let it be as-is.

	Sam
