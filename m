Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVA0UCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVA0UCk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVA0UCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:02:25 -0500
Received: from acomp.externet.hu ([212.40.96.68]:11712 "HELO www.acomp.hu")
	by vger.kernel.org with SMTP id S261153AbVA0UBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:01:02 -0500
Date: Thu, 27 Jan 2005 21:00:56 +0100
From: Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>
To: David Brownell <david-b@pacbell.net>
Cc: David Ford <david+challenge-response@blue-labs.org>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.11-rc2 TCP ignores PMTU ICMP (Re: Linux 2.6.11-rc2)
Message-ID: <priv$1106854599.koan@lk8rp.mail.xeon.eu.org>
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	David Ford <david+challenge-response@blue-labs.org>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <200501232251.42394.david-b@pacbell.net> <200501251054.37053.david-b@pacbell.net> <priv$1106815487.koan@shadow.banki.hu> <200501271128.48411.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501271128.48411.david-b@pacbell.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-01-27 at 11:28:48, David Brownell wrote:
> > Indeed, I had to shuffle my machines around a bit to get a proof that
> > something is broken, but now I can confirm the above with a connection
> > to cvs.sourceforge.net:
> 
> Thanks for confirming it wasn't just me ... I confess I'm a bit
> surprised more folk haven't reported this yet! 
> 
> Your symptoms are exactly like those I saw, just with a different
> mission-critical application:  CVS, not SMTP.  Did you happen to
> notice whether CVS pulls worked, when pushes (like this) failed?

I'm familiar with symptoms arising from various stochastic/assymetric
networking problems with larger frames, I had cable :)  This was a pull
(update), BTW, CVS can send more data in this situation too.  But it
turned painfully obvious when trying to send mail to LK via SMTP.  Oh,
but while plain rc2 may have this problem, this particular endpoint had
rc2-bk3 running.  I also chose to set the ethernet MTU to 1492 as an
easy workaround...

-- 
Janos | romfs is at http://romfs.sourceforge.net/ | Don't talk about silence.
