Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWDVTc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWDVTc2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWDVTc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:32:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18703 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751073AbWDVTcX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:32:23 -0400
Date: Thu, 20 Apr 2006 21:18:23 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Lukasz Stelmach <stlman@poczta.fm>
Cc: linux-kernel@vger.kernel.org
Subject: Re: quantum capabilities
Message-ID: <20060420211822.GC2360@ucw.cz>
References: <444650E1.5020403@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444650E1.5020403@poczta.fm>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-04-06 17:01:53, Lukasz Stelmach wrote:
> Greetings All.
> 
> I've found a strange phenomenon associated with capabilities. It seems to be a
> quantum like.
> 
> when I run (as root)
> 
> delfin:~# /usr/sbin/execcap '= cap_net_raw=ep' /bin/sh -c 'getpcaps $$'
> Capabilities for `2438': =ep cap_setpcap-ep
> 
> I don't know what really happens to those capablities I zero. And I can't really
> figure out for when I try the wavefunction collapses
> 
> delfin:~# strace -o /dev/null /usr/sbin/execcap '= cap_net_raw=ep' /bin/sh -c \
> 'getpcaps $$'
> Capabilities for `2461': = cap_net_raw+ep
> 
> Strange isn't it? Does it mean that processes can't really drop their privileges?

Is execcap setuid? strace does not work over setuid...


						Pavel

-- 
Thanks, Sharp!
