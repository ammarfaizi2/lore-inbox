Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbTBTObI>; Thu, 20 Feb 2003 09:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbTBTObI>; Thu, 20 Feb 2003 09:31:08 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:41133 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261799AbTBTObH>;
	Thu, 20 Feb 2003 09:31:07 -0500
Subject: Re: [PATCH] IPSec protocol application order
To: "David S. Miller" <davem@redhat.com>
Cc: cw@f00f.org, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OFEE5E8DF8.35868017-ON86256CD3.004F81AF-86256CD3.005099DD@pok.ibm.com>
From: "Tom Lendacky" <toml@us.ibm.com>
Date: Thu, 20 Feb 2003 08:40:22 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 02/20/2003 09:40:25 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I believe that good documentation will also be required then.  If it is
being decided that the user must enter the ipsec protocols in the proper
order using the setkey spdadd operation, then the user will need to know
what order in which to specify the arguments to setkey.  Given that the
spdadd operation:

  spdadd src-ip dst-ip any -P out ipsec ah/transport//require
esp/transport//require;

would result in improper ordering of the AH and ESP headers and therefore
interoperability problems, while

  spdadd src-ip dst-ip any -P out ipsec esp/transport//require
ah/transport//require;

results in the proper order.

No where have I been able to find any user level documentation that says
what order the ipsec protocols need to be specified on the spdadd
operation.  Without good documentation I believe support centers, both a
customer's own and/or a distributor's, may be getting a lot of unnecessary
calls.

Tom



