Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262771AbVD2PS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbVD2PS0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 11:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbVD2PS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 11:18:26 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:43615 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262771AbVD2PSV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 11:18:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h6vEASOO1af6FVMS5XEPwz7e8lGo+CGQrM1Lg1qyO89qlz9ePa8EtMcpOyME5a3Kf4Ra/AEE0BlKo+wLHvpFwkEnY78+clQs92ucDB40dZxe2gKMAXxwdMTRSJbtWdzZG5ydiJ4Clh5/VOcH5AnPsEZPG74jXAUgLVirNAhw5N4=
Message-ID: <118833cc05042908181d09bdfd@mail.gmail.com>
Date: Fri, 29 Apr 2005 11:18:20 -0400
From: Morten Welinder <mwelinder@gmail.com>
Reply-To: Morten Welinder <mwelinder@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Cc: Matt Mackall <mpm@selenic.com>, Sean <seanlkml@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0504290728090.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050426004111.GI21897@waste.org>
	 <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
	 <20050429060157.GS21897@waste.org>
	 <3817.10.10.10.24.1114756831.squirrel@linux1>
	 <20050429074043.GT21897@waste.org>
	 <Pine.LNX.4.58.0504290728090.18901@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I had three design goals. "disk space" wasn't one of them

And, if at some point it should become an issue, it's fixable.  Since
access to objects
is fairly centralized and since they are immutable, it would be quite
simple to move
an arbitrary selection of the objects into some other storage form
which could take
similarities between objects into account.

If you chose the selection of objects with care -- say those for files
that have changed
many times since -- it shouldn't even hurt performance of day-to-day
tasks (which aren't
likely to ever need those objects).

So disk space and its cousin number-of-files are both when-and-if
problems.  And not
scary ones at that.

Morten
