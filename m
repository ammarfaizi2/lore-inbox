Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbWHQOMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbWHQOMc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWHQOMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:12:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64186 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964872AbWHQOMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:12:30 -0400
Date: Thu, 17 Aug 2006 10:12:01 -0400
From: Bill Nottingham <notting@redhat.com>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Bodo Eggert <7eggert@gmx.de>, "Giacomo A. Catenazzi" <cate@debian.org>,
       David Miller <davem@davemloft.net>, 7eggert@elstempel.de,
       shemminger@osdl.org, mitch.a.williams@intel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: bonding: cannot remove certain named devices
Message-ID: <20060817141201.GB18904@nostromo.devel.redhat.com>
Mail-Followup-To: Xavier Bestel <xavier.bestel@free.fr>,
	Bodo Eggert <7eggert@gmx.de>,
	"Giacomo A. Catenazzi" <cate@debian.org>,
	David Miller <davem@davemloft.net>, 7eggert@elstempel.de,
	shemminger@osdl.org, mitch.a.williams@intel.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6KfTz-OX-11@gated-at.bofh.it> <6KfTA-OX-15@gated-at.bofh.it> <E1GD8rX-0001cA-CV@be1.lrz> <20060815.171002.104028951.davem@davemloft.net> <44E2BC9C.1000101@debian.org> <20060816133811.GA26471@nostromo.devel.redhat.com> <Pine.LNX.4.58.0608161636250.2044@be1.lrz> <1155799783.7566.5.camel@capoeira>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155799783.7566.5.camel@capoeira>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel (xavier.bestel@free.fr) said: 
> > I think it's sane to avoid control characters and unicode/iso*, since they
> > can interfere with log output or analysis. I only thought about the kernel
> > itself and the corresponding userspace tools, which should handle any
> > character sequence just fine or could be easily fixed.
> 
> Why not simply retricting chars to isalnum() ones ?

People might want to use things like '-', '_', etc. 

Realistically, any filtering that is done with names has the chance of
breaking 'working' configs that date back to 2.4.

Bill
