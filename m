Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136579AbREEAwu>; Fri, 4 May 2001 20:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136583AbREEAwk>; Fri, 4 May 2001 20:52:40 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:9235 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S136579AbREEAwd>;
	Fri, 4 May 2001 20:52:33 -0400
Date: Fri, 4 May 2001 20:53:12 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: CML2 1.4.0, aka "brutality and heuristics"
Message-ID: <20010504205312.A27435@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version is always available at http://www.tuxedo.org/~esr/cml2/

Release 1.4.0: Fri May  4 18:18:15 EDT 2001
	* Ugly hack for recovery from inconsistent configurations.

We've spent a lot of time and effort recently arguing about elaborate
recovery algorithms for the extremely unusual case that the CML2
configurator loads a configuration that has become invalid because of
a constraint added to the rulebase since the configuration was
written.  (Mere addition of new symbols doesn't trigger this.)

The general problem is theoretically hard and for practical purposes
insoluble, so I've have implemented a suggestion by Dave Wagner and
John Stoffel.  CML2 will now try to recover fom a load-time
inconsistency by smashing all the non-frozen symbols in the violated
constraint to the value N (and notifying the user that it's doing so).
This is ugly, but will handle most cases.  In the few it doesn't
handle, the bindings loaded from the file will be backed out as a
unit.  In any case the user will be left in a running configurator.

Sigh...now, I hope, we can get back to solving problems that I don't
expect to be so rare they're lost in the statistical noise.  It's not
good to get so obsessed about finding clever solutions to corner cases
that one loses sight of the larger issues.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The prestige of government has undoubtedly been lowered considerably
by the Prohibition law. For nothing is more destructive of respect for
the government and the law of the land than passing laws which cannot
be enforced. It is an open secret that the dangerous increase of crime
in this country is closely connected with this.
	-- Albert Einstein, "My First Impression of the U.S.A.", 1921
