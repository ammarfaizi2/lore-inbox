Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284435AbRLFPzq>; Thu, 6 Dec 2001 10:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284432AbRLFPzh>; Thu, 6 Dec 2001 10:55:37 -0500
Received: from mail.redhat.com ([199.183.24.239]:41487 "EHLO mail.redhat.com")
	by vger.kernel.org with ESMTP id <S284300AbRLFPz0>;
	Thu, 6 Dec 2001 10:55:26 -0500
Date: Thu, 6 Dec 2001 09:56:04 -0600
From: Jason Kohles <jkohles@redhat.com>
To: Keith Warno <krjw@optonline.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 + strace 4.4 + setuid programs
Message-ID: <20011206095604.B1975@traveller.localdomain>
In-Reply-To: <Pine.LNX.4.40.0112060104140.32509-100000@behemoth.hobitch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0112060104140.32509-100000@behemoth.hobitch.com>; from krjw@optonline.net on Thu, Dec 06, 2001 at 01:09:02AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 01:09:02AM -0500, Keith Warno wrote:
> Hmm.  Is strace supposed to be capable of tracing setuid programs (ie,
> su) when executed by mortal users?  I always thought this was a big
> no-no.
> 
You can trace them, but strace will ignore the setuid bit on the process,
for example if you strace su, you will see a lot of permission denied, as
it won't actually run as root, and won't be able to open things like
/etc/shadow or /proc/self/fd/0.  If you want to strace setuid things and
have the setuid bit honored, you have to run strace as root with the -u
option.

-- 
Jason Kohles                                 jkohles@redhat.com
Senior System Architect                      (703)786-8036 (cellular)
Red Hat Professional Consulting              (703)456-2940 (office)
