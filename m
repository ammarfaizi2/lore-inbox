Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030413AbWAXJPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbWAXJPo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 04:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWAXJPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 04:15:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:5588 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030413AbWAXJPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 04:15:43 -0500
Subject: Re: Rationale for RLIMIT_MEMLOCK?
From: Arjan van de Ven <arjan@infradead.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org
In-Reply-To: <43D5EEA2.nailCE7111GPO@burner>
References: <20060123105634.GA17439@merlin.emma.line.org>
	 <1138014312.2977.37.camel@laptopd505.fenrus.org>
	 <20060123165415.GA32178@merlin.emma.line.org>
	 <1138035602.2977.54.camel@laptopd505.fenrus.org>
	 <20060123180106.GA4879@merlin.emma.line.org>
	 <1138039993.2977.62.camel@laptopd505.fenrus.org>
	 <20060123185549.GA15985@merlin.emma.line.org>
	 <43D530CC.nailC4Y11KE7A@burner>
	 <20060123203010.GB1820@merlin.emma.line.org>
	 <1138092761.2977.32.camel@laptopd505.fenrus.org>
	 <43D5EEA2.nailCE7111GPO@burner>
Content-Type: text/plain
Date: Tue, 24 Jan 2006 10:15:40 +0100
Message-Id: <1138094141.2977.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-24 at 10:08 +0100, Joerg Schilling wrote:
> > the situation is messy; I can see some value in the hack Ted proposed to
> > just bump the rlimit automatically at an mlockall-done-by-root.. but to
> > be fair it's a hack :(
> 
> As all other rlimits are honored even if you are root, it looks not orthogonal 
> to disregard an existing RLIMIT_MEMLOCK rlimit if you are root.

that's another solution; give root a higher rlimit by default for this.
It's also a bit messy, but a not-unreasonable default behavior.


