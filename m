Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbTEBSQn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 14:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263072AbTEBSQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 14:16:42 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:41167 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263071AbTEBSQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 14:16:36 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: root@chaos.analogic.com, Riley Williams <Riley@Williams.Name>
Subject: Re: is there small mistake in lib/vsprintf.c of kernel 2.4.20 ?
Date: Fri, 2 May 2003 13:23:50 -0500
User-Agent: KMail/1.5
Cc: viro@parcelfarce.linux.theplanet.co.uk, Bodo Rzany <bodo@rzany.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <BKEGKPICNAKILKJKMHCAKEBLCKAA.Riley@Williams.Name> <Pine.LNX.4.53.0305021305250.9707@chaos>
In-Reply-To: <Pine.LNX.4.53.0305021305250.9707@chaos>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305021323.50125.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 May 2003 12:15, Richard B. Johnson wrote:
> Kevin Corry <kevcorry@us.ibm.com>, submitted a patch which breaks
> already working code in an aparent attempt to fix the leading
> "0x" problem.

It is not a patch to fix the leading "0x" problem. It is a patch to fix 
scanning of hex numbers which do *not* start with "0x". Hex numbers starting 
with "0x" will already scan correctly. Like I said before, try scanning "fe" 
as a hex number, and watch scanf return an error. Like I also said before, 
this same patch has been in 2.5 for quite a while, so I fail to see why it 
shouldn't also be applied to 2.4, unless we are specifically trying to 
maintain different behavior for scanf between the two kernel versions.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

