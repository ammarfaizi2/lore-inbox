Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267566AbUHaJRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267566AbUHaJRG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 05:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267591AbUHaJRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 05:17:05 -0400
Received: from open.hands.com ([195.224.53.39]:37814 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S267555AbUHaJQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 05:16:41 -0400
Date: Tue, 31 Aug 2004 10:27:51 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fireflier firewall userspace program doing userspace packet filtering
Message-ID: <20040831092751.GK31497@lkcl.net>
References: <20040830104202.GG3712@lkcl.net> <20040830181519.GE8382@lkcl.net> <1093893366.7064.176.camel@sherbert> <20040830200023.GA31497@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830200023.GA31497@lkcl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 09:00:23PM +0100, Luke Kenneth Casson Leighton wrote:
> On Mon, Aug 30, 2004 at 08:16:06PM +0100, Gianni Tedesco wrote:
> > On Mon, 2004-08-30 at 19:15 +0100, Luke Kenneth Casson Leighton wrote:
> > > so, my question, therefore, is:
> > > 
> > > 	what should i record in a modified version of ipt_owner in
> > > 	order to "vet" packets on a per-executable basis?
> > > 
> > > 	should i consider recording the inode of the program's binary?
> > 
> > Bear in mind that that would make sense for an ACCEPT rule, but for a
> > DROP rule, copying the binary would bypass the check.
>  
>  i understand!
> 
>  i thought that selinux by default would stop me from being
>  able to copy binaries from /usr/bin.... uhn... no such luck.
> 
>  if it becomes an issue i will investigate removing read access!
 
 okay.

 first thing:

 1) assuming that the DROP rule issue is one that cannot be avoided,
    and that a rules design policy of "deny everything and only allow
	specifics" is required, then checking on the _full_ pathname
	of the program is required.

 second thing:

 2) it _is_ possible to hunt through the selinux policy macros to
    remove the execute permission on binaries that a user drops into
	their home directory, or copies into their home directory.

 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

