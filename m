Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264459AbTEPP00 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 11:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTEPP00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 11:26:26 -0400
Received: from PACIFIC-CARRIER-ANNEX.MIT.EDU ([18.7.21.83]:37078 "EHLO
	pacific-carrier-annex.mit.edu") by vger.kernel.org with ESMTP
	id S264451AbTEPP0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 11:26:25 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       David Howells <dhowells@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG support
References: <Pine.LNX.4.44.0305130849480.1562-100000@home.transmeta.com>
	<1052840663.463.64.camel@dhcp22.swansea.linux.org.uk>
From: Derek Atkins <warlord@MIT.EDU>
Date: 16 May 2003 11:38:58 -0400
In-Reply-To: <1052840663.463.64.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <sjm65oaewa5.fsf@kikki.mit.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> How does AFS currently handle this, can two logins of the same user have
> seperate PAGs ?

Yes.  Indeed, individual logins usually DO have separate PAGs (as the
login program runs setpag() to create a new pag).  Moreover, there is
a program called "pagsh" which allows a user to create a shell in a
new PAG -- allowing multiple PAGs even in one login session for a
single "user".

-derek
-- 
       Derek Atkins, SB '93 MIT EE, SM '95 MIT Media Laboratory
       Member, MIT Student Information Processing Board  (SIPB)
       URL: http://web.mit.edu/warlord/    PP-ASEL-IA     N1NWH
       warlord@MIT.EDU                        PGP key available
