Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbTBSVjD>; Wed, 19 Feb 2003 16:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbTBSVjC>; Wed, 19 Feb 2003 16:39:02 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:16794 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261724AbTBSVjA>;
	Wed, 19 Feb 2003 16:39:00 -0500
Subject: Re: [PATCH] IPSec protocol application order
To: "David S. Miller" <davem@redhat.com>
Cc: "Alexey N. Kuznetsov" <kuznet@ms2.inr.ac.ru>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF8FC87DCF.42F7A5C1-ON86256CD2.007686FA-86256CD2.0077C5EA@pok.ibm.com>
From: "Tom Lendacky" <toml@us.ibm.com>
Date: Wed, 19 Feb 2003 15:48:14 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 02/19/2003 04:48:16 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> The IPSec RFC (2401) and IPComp RFC (3173) specify the order in which
>> the COMP, ESP and AH protocols must be applied when being applied in
>> transport mode.  Specifically, COMP must be applied first, then ESP
>> and then AH.  Also, transport mode protocols must be applied before
>> tunnel mode protocols.

> Did you even read the email from Alexey yesterday that described
> why none of this is a kernel issue and we merely do exactly what
> the user application tells us to do when it uploads key configuration?

> Just like you aparently ignored his email, I will ignore your patch.

Yes, I read Alexey's email.  He said that it is not a kernel or a setkey
issue.  One of them is responsible for making sure the proper order is set
in order to insure RFC conformance and interoperability.  You are saying
that it is up to the user application, which would be setkey.  So if you
would prefer to not do this in the kernel you can ignore the patch, but
then the setkey application needs to be fixed.

Tom



