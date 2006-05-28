Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWE1KNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWE1KNQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 06:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWE1KNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 06:13:15 -0400
Received: from gw.openss7.com ([142.179.199.224]:53941 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1750712AbWE1KNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 06:13:15 -0400
Date: Sun, 28 May 2006 04:13:12 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Lee Revell <rlrevell@joe-job.com>, devmazumdar <dev@opensound.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
Message-ID: <20060528041312.A13564@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Lee Revell <rlrevell@joe-job.com>, devmazumdar <dev@opensound.com>,
	linux-kernel@vger.kernel.org
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe> <1148653797.3579.18.camel@laptopd505.fenrus.org> <20060526093530.A20928@openss7.org> <1148732512.3265.0.camel@laptopd505.fenrus.org> <20060527135214.A15216@openss7.org> <1148761299.3265.241.camel@laptopd505.fenrus.org> <20060527162118.E15216@openss7.org> <1148804871.3074.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1148804871.3074.2.camel@laptopd505.fenrus.org>; from arjan@infradead.org on Sun, May 28, 2006 at 10:27:51AM +0200
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan,

On Sun, 28 May 2006, Arjan van de Ven wrote:

> 
> > But not the right place for the running kernel.  /boot/config-`uname -r` will
> > be of the wrong architecture for the running kernel.
> 
> so yes you can use --force to cause it to overwrite a file. DUH.
> Big yawn as will since this file isn't needed for anything but for a
> human to build his own kernel; if that human first does the really silly
> --force thing (which is a great way to hose your system) then he knows
> there might not be an exact match. Big Yawn(tm) :)
> 

Well, Mandriva doesn't have even this problem because the architecture is
part of the kernel name.

For others its worth sanity checking

  rpm -q --qf "%{ARCH}\n" --what-provides /boot/config-`uname -r`

against

  uname -m

to ensure that the architecture matches.

--brian
