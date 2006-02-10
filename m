Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWBJVAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWBJVAG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 16:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWBJVAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 16:00:06 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:38570 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1751373AbWBJVAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 16:00:04 -0500
Date: Fri, 10 Feb 2006 22:00:06 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: CD-blanking leads to machine freeze with current -git [was: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]]
Message-ID: <20060210210006.GA5585@stiffy.osknowledge.org>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <20060210175848.GA5533@stiffy.osknowledge.org> <43ECE734.5010907@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ECE734.5010907@cfl.rr.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-g418aade4-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Phillip Susi <psusi@cfl.rr.com> [2006-02-10 14:19:16 -0500]:

> Marc Koschewski wrote:
> >I just tried blanking a CD-RW with the latest -git tree. The machine just 
> >became
> >unresponsive and then froze. When it became unresponsive the clock in 
> >GNOME still
> >displayed the current time but I could not focus any windows anymore. Then 
> >I had
> >to hard reboot the machine. The logs say nothing. I repeat: nothing.
> >
> >Does anyone have similar problems?
> 
> Instead of rebooting, just wait for the blanking to finish.  My guess is 
> that your burner and hard drive are both on the same ide channel, and so 
> you can not access the disk while the burner is blanking.  If this is 
> the case, put each drive on their own ide channel. 

I've been waiting 30 minutes for the machine to come back but no chance. SSH
didn't work either. I thought I could login remote... but uh uh.

The problem is, it's a laptop. So there not much chance to move the cdrom device
over to another controller or whatever. ;)

But let's face it: is it really crappy to render a laptop unusable just because
blanking a CD-RW. The circumstances were: run xcdroast via gksu (thus running as
root), blank CD-RW. Due to cd-burning being totally unusable as a user (problems
here and there if it was just doing anything at all). So I've no other chance
than to run this as root. Couldn't cdrecord 'watch' ide load or - even better -
forcecast it? It knows blanking leads to inresponsiveness sometimes (even more due
to the fact that both devices share the same bus). Why not kind of  'renice'
the process that blanks?

Marc
