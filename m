Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264888AbSKJOjy>; Sun, 10 Nov 2002 09:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264889AbSKJOjy>; Sun, 10 Nov 2002 09:39:54 -0500
Received: from ausadmmsrr504.aus.amer.dell.com ([143.166.83.91]:21007 "HELO
	AUSADMMSRR504.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S264888AbSKJOjy>; Sun, 10 Nov 2002 09:39:54 -0500
X-Server-Uuid: 5b9b39fe-7ea5-4ce3-be8e-d57fc0776f39
Message-ID: <20BF5713E14D5B48AA289F72BD372D68C1EB68@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: RE: BOGUS: megaraid changes
Date: Sun, 10 Nov 2002 08:46:33 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 11D0AEC05316946-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus - will you please stop merging plain dangerous "lets pretend we
> never have errors" patches. I've got proper fixes for megaraid to use
> the new_eh if you want them, but merging stuff so that people 
> don't even notice the problem is *WRONG*

That one's my mistake, it made to Linus via my sending patches at linux-scsi
and James.  Alan, I saw your megaraid updates after I posted these to l-s,
and was in the process of merging the two, which I didn't finish on Friday.

The megaraid driver, especially in 2.5.x, has been suffering from neglect
from the official maintainer, LSI.  Atul has returned from lengthy hiatus,
and claims to be ready to get megaraid back into working shape.  I *really*
want Atul to get 2.4.x straightened out as a first priority this week, and
then tackle 2.5.x ASAP thereafter.  Ideally for 2.5, after a short
stabilization period for the current 1.18 driver and in parallel a merging
of megaraid2, that the 1.18 driver could be dropped in favor of a cleaner
(and proper error-handling) megaraid 2.00 driver.  There's even hope that
some megaraid cards can actually do board resets (not all can), and that
logic could be incorporated into the error handling routines.  As it stands
now, they are no-ops once a command had been sent to the card.

-Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

