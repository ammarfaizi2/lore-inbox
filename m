Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751591AbWDYQ1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbWDYQ1O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 12:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbWDYQ1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 12:27:14 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:11397 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751586AbWDYQ1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 12:27:12 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] 
	implementation of LSM hooks)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Lang <dlang@digitalinsight.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lars Marowsky-Bree <lmb@suse.de>, Valdis.Kletnieks@vt.edu,
       Ken Brush <kbrush@gmail.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0604240730030.30494@qynat.qvtvafvgr.pbz>
References: <4446D378.8050406@novell.com>
	 <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu>
	 <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com>
	 <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu>
	 <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com>
	 <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu>
	 <20060424082424.GH440@marowsky-bree.de>
	 <1145882551.29648.23.camel@localhost.localdomain>
	 <20060424125641.GD9311@sergelap.austin.ibm.com>
	 <1145887333.29648.44.camel@localhost.localdomain>
	 <20060424140407.GD22703@sergelap.austin.ibm.com>
	 <Pine.LNX.4.62.0604240730030.30494@qynat.qvtvafvgr.pbz>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 25 Apr 2006 12:31:43 -0400
Message-Id: <1145982703.21399.42.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 07:45 -0700, David Lang wrote:
> One key difference between SELinux and AppArmor is that AA is _not_ 
> designed to protect against the actions of root, it's designed to block 
> attacks that would let someone become root.

This doesn't match the documentation or implementation AFAICS.  It
specifically controls capabilities to limit root processes, and its lack
of complete mediation and use of ambiguous identifiers leaves open a
variety of paths to escalation of access.

> becouse of this strategy it's far simpler to configure becouse you do not 
> have to do all the work to control root. This also limits what it can 
> defend against, and so it's not 'perfect security' (and after all there is 
> only one way to get 'perfect security' 
> http://www.ranum.com/security/computer_security/papers/a1-firewall/ ), but 
> AA is still a useful tool.
> 
> the 'hard shell, soft center' approach isn't as secure as 'full 
> hardening' (assuming that both are properly implemented), but the fact 
> that it's far easier to understand and configure the hard shell means that 
> it's also far more likly to be implemented properly.
> 
> remember that it's not really a matter of people deciding not to write 
> SELinux policies and instead do AA, it's a matter of people deciding to 
> use AA instead of doing nothing.

Is it?  Or it a matter of people deciding to use AA and rely on it
versus e.g. using a conventional jail-style or virtualization mechanism
ala VServer or OpenVZ?

-- 
Stephen Smalley
National Security Agency

