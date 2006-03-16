Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWCPIIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWCPIIT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 03:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWCPIIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 03:08:18 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:30860 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932383AbWCPIIS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 03:08:18 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Subject: Re: /dev/stderr gets unlinked 8]
Date: Thu, 16 Mar 2006 10:07:51 +0200
User-Agent: KMail/1.8.2
Cc: "Andreas Schwab" <schwab@suse.de>, "Stefan Seyfried" <seife@suse.de>,
       linux-kernel@vger.kernel.org, christiand59@web.de
References: <200603141213.00077.vda@ilport.com.ua> <200603151534.41899.vda@ilport.com.ua> <Pine.LNX.4.61.0603150913540.12854@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0603150913540.12854@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603161007.51237.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 March 2006 16:23, linux-os (Dick Johnson) wrote:
> 
> On Wed, 15 Mar 2006, Denis Vlasenko wrote:
> 
> > On Wednesday 15 March 2006 15:14, Andreas Schwab wrote:
> >> Stefan Seyfried <seife@suse.de> writes:
> >>
> >>> any good daemon closes stdout, stderr, stdin
> >>
> >> A real good daemon would redirect them to /dev/null.
> >
> > Yeah, yeah, let's first close stderr, and then proceed and
> > add some code to handle command line --log=file, and to do
> > logging to that file.
> >
> > Why good ol' fprintf(stderr,...) isn't enough? Why do you
> > want to complicate things?
> >
> > What's so hard in doing "daemon 2>/dev/null &" if you don't
> > want to save log?
> > --
> > vda
> 
> The daemon needs to have the standard input closed as well as
> any I/O connection to a possible terminal. Just closing
> standard input, allows a dup() in rogue code to recreate it.
> Basically, file-descriptors 0, 1, and 2, need to be USED and
> used for something else (like open /dev/null or open "/").
> That's how you prevent rogue code, inserted via overflow or
> other means, from obtaining control of your system.

... and everything described above is perfectly doable by
shell mechanisms (like redirections) prior to strting daemon, right?
--
vda
