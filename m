Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbWEYU3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbWEYU3T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 16:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbWEYU3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 16:29:19 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:38834 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1030368AbWEYU3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 16:29:18 -0400
Date: Thu, 25 May 2006 16:29:17 -0400
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Kyle McMartin <kyle@mcmartin.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain (was: Re: [PATCH] Well, Linus seems to like Lordi...)
Message-ID: <20060525202917.GB21926@csclub.uwaterloo.ca>
References: <20060525141714.GA31604@skunkworks.cabal.ca> <Pine.LNX.4.61.0605252027380.13379@yvahk01.tjqt.qr> <Pine.LNX.4.64.0605251146260.5623@g5.osdl.org> <200605251954.06227.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605251954.06227.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 07:54:06PM +0100, Alistair John Strachan wrote:
> This is probably a broken configuration, but it would cause a regression for 
> me:
> 
> [alistair] 19:53 [~] hostname
> damocles
> 
> [alistair] 19:52 [~] hostname --fqdn
> localhost
> 
> "localhost" isn't very descriptive if I'm trying to figure out which machine a 
> dmesg came from.

rceng02:~# hostname
rceng02
rceng02:~# hostname -f
rceng02.eng.lan
rceng02:~# head -1 /etc/hosts
127.0.0.1       rceng02.eng.lan localhost.localdomain   localhost
rceng02
rceng02:~#

I always thought that was how it worked.  The first hostname in
/etc/hosts on the line containing the short name was used as the FQDN.
Maybe that is only a gnu hostname thing.  I seem to recall solaris had a
domainname file that was used to find the domain part of the FQDN
instead.

Len Sorensen
