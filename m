Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTEMQjo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbTEMQjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:39:44 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:62101 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261956AbTEMQjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:39:40 -0400
Date: Tue, 13 May 2003 12:52:24 -0400
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] in-core AFS multiplexor and PAG support
Message-ID: <20030513165224.GA25295@delft.aura.cs.cmu.edu>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
References: <Pine.LNX.4.44.0305130849480.1562-100000@home.transmeta.com> <1052840663.463.64.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052840663.463.64.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 04:44:24PM +0100, Alan Cox wrote:
> On Maw, 2003-05-13 at 16:52, Linus Torvalds wrote:
> > I think the code looks pretty horrible, but I think we'll need something
> > like this to keep track of keys. However, I'm not sure we should make this
> > a new structure - I think we should make the current "tsk->user" thing
> > _be_ the "PAG". 
> 
> With something like SELinux a PAG may belong to a role not to a user
> even though other limits like processes probably belong to the user as a
> whole. 
> 
> How does AFS currently handle this, can two logins of the same user have
> seperate PAGs ?

Yes, easily and it is useful.

I can start an xterm a new PAG that has administrative rights. Or
various system daemons all running with uid 0, but with different access
rights (sendmail/webserver).

It also goes the other way around, different uid's using the same PAG,
if I run a setuid application it can still access my files.

Jan

