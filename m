Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293627AbSCGTGl>; Thu, 7 Mar 2002 14:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310452AbSCGTGb>; Thu, 7 Mar 2002 14:06:31 -0500
Received: from bitmover.com ([192.132.92.2]:31113 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S293627AbSCGTGU>;
	Thu, 7 Mar 2002 14:06:20 -0500
Date: Thu, 7 Mar 2002 11:06:17 -0800
From: Larry McVoy <lm@bitmover.com>
To: Ed Vance <EdV@macrolink.com>
Cc: "'Jean-Luc Leger'" <reiga@dspnet.fr.eu.org>, linux-kernel@vger.kernel.org
Subject: Re: Petition Against Official Endorsement of BitKeeper by Linux M aintainers
Message-ID: <20020307110617.C20271@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ed Vance <EdV@macrolink.com>,
	'Jean-Luc Leger' <reiga@dspnet.fr.eu.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A76E0@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A76E0@EXCHANGE>; from EdV@macrolink.com on Thu, Mar 07, 2002 at 10:56:08AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 10:56:08AM -0800, Ed Vance wrote:
> On Thu, Mar 07, 2002 at 10:03 AM, Jean-Luc Leger wrote:
> > > Larry McVoy <lm@bitmover.com> writes:
> > > >	bk prs -hrv2.5.0.. |  while read x
> > 
> > by the way, shouldn't it be "$x" in the second line ?
> > or am I missing something ?
> > 
> > 	JL
> 
> man bash
> ...
>     read  [-ers]  [-t  timeout]  [-a  aname]  [-p  prompt] [-n
>           nchars] [-d delim] [name ...] 

We're getting well into programming 101 and I should just shut up, but
here:

	cat > mkpatches <<EOF
	#!/bin/sh

	bk prs -hr"$1".. |  while read x
	do	bk export -tpatch -r$x > /tmp/patches/patch-$x
	done
	EOF

Yes, I believe you need cat and a Bourne compatible shell for the <<EOF
stuff and we really don't need a listing of all the shells in which this
will and will not work.

The point, which seems to be completely lost in the "I can program in 
shell better than you" discussion, is that it is trivial to export 
changes from BK as patches.  Given that the world turns on patches
today, that should be the end of the discussion and insofar as I am
concerned, it is the end of the discussion.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
