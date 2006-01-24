Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWAXXUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWAXXUB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 18:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWAXXUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 18:20:01 -0500
Received: from mail.gmx.de ([213.165.64.21]:32398 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750824AbWAXXUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 18:20:00 -0500
X-Authenticated: #271361
Date: Wed, 25 Jan 2006 00:19:55 +0100
From: Edgar Toernig <froese@gmx.de>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: Rationale for RLIMIT_MEMLOCK?
Message-Id: <20060125001955.3d11ff36.froese@gmx.de>
In-Reply-To: <20060124212843.GA15543@thunk.org>
References: <20060123165415.GA32178@merlin.emma.line.org>
	<1138035602.2977.54.camel@laptopd505.fenrus.org>
	<20060123180106.GA4879@merlin.emma.line.org>
	<1138039993.2977.62.camel@laptopd505.fenrus.org>
	<20060123185549.GA15985@merlin.emma.line.org>
	<43D530CC.nailC4Y11KE7A@burner>
	<20060123203010.GB1820@merlin.emma.line.org>
	<1138092761.2977.32.camel@laptopd505.fenrus.org>
	<43D5EEA2.nailCE7111GPO@burner>
	<1138094141.2977.34.camel@laptopd505.fenrus.org>
	<20060124212843.GA15543@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
>
> ... proposed a hack where mlockall() would adjust RLIMIT_MEMLOCK.
> Yes, no question it's a hack and a special case; the question is
> whether cure or the disease is worse.

What about exec?  The memory locks are removed on exec but with that
hack the raised limit would stay.  Looks like a security bug.

Ciao, ET.
