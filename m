Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbUAEMHR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 07:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264245AbUAEMHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 07:07:16 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:12468
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S264229AbUAEMHO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 07:07:14 -0500
Subject: Re: [offtopic] Re: udev and devfs - The final word
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: rob@landley.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200401050103.13032.rob@landley.net>
References: <20040103040013.A3100@pclin040.win.tue.nl>
	 <200401042148.24742.rob@landley.net>
	 <1073278352.1165.36.camel@nidelv.trondhjem.org>
	 <200401050103.13032.rob@landley.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1073304433.1168.88.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Jan 2004 07:07:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 05/01/2004 klokka 02:03, skreiv Rob Landley:

> I'm sure it's still useful.  I just haven't wanted to even attempt to secure 
> it.  For home directories, samba is doing a simple tcp/ip connection per 
> session, reestablishing it automatically if it breaks (same server reboot 
> question).

...and so does NFS.

>   Since _both_ protocols seem to suck pretty badly under the hood, 
> it's been a question of choosing the lesser of two evils.  It seems that more 
> people actually USE samba, so...

...and 95% of all desktop machines are Windows based. So what's new?

> > It could be done (and probably entirely in userspace). I assume you are
> > volunteering to do the work?
> 
> I don't like nfs, I haven't bothered to actually use it for anything since 
> 1999, so no.

Then you're unlikely to get the feature until someone else finds it
worth their while to implement it.

> I can transparently tunnel any tcp/ip session through ssh with some iptables 
> rules and a dozen line python script.  (Great fun for rolling your own vpn.)  
> Mixing UDP and encryption is just plain a bad idea: no level at which it 
> makes sense to store persistent connection state in a "fire and forget" 
> packet protocol...)

So do the same thing with NFS now that we've finally gotten RPC over TCP
fully supported under Linux too: everybody else has had it for years.

In 2.6.x, we've also added native RPCSEC_GSS support for kerberos-based
authentication. Packet integrity checking and full privacy are in the
pipeline, as are other security mechanisms.

> Can you recommend a good link to the history of NFS?  Computer history's a 
> hobby of mine.  (I've got snippets on this topic, but not any kind of unified 
> story of NFS...)

Dunno if anybody has ever written a proper history of NFS, but I can ask
around. Here are a few sources I found on the fly though. They all tend
to relate to the history of the protocol, and not much about
implementation history (shame that).

NFSv2 transition to NFSv3
        http://www.netapp.com/tech_library/evolution.html
        RFC1813

transition to NFSv4 
        http://www.ietf.org/html.charters/nfsv4-charter.html
        (in particular see http://www.ietf.org/rfc/rfc2624.txt which
        runs through the earlier design considerations)
        RFC3530 (the final version of the protocol)

I'd also recommend nosing around the Connectathon site on
http://www.connectathon.org/
That contains a record of talks going back to 95 (not really that long -
I know) and so should help out with the more recent history.

...of course if you google around, you'll also find loads of Powerpoint
presentations etc...

Cheers,
  Trond
