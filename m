Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263687AbUFIM0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUFIM0y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 08:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265758AbUFIMYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 08:24:01 -0400
Received: from [203.178.140.15] ([203.178.140.15]:30993 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S265747AbUFIMXo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 08:23:44 -0400
Date: Wed, 09 Jun 2004 21:24:30 +0900 (JST)
Message-Id: <20040609.212430.123946645.yoshfuji@linux-ipv6.org>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: netdev@oss.sgi.com, linux-net@vger.kernel.org, davem@redhat.com,
       pekkas@netcore.fi, jmorris@redhat.com, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: UDP sockets bound to ANY send answers with wrong src ip address
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200406091425.39324.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200406091425.39324.vda@port.imtp.ilyichevsk.odessa.ua>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200406091425.39324.vda@port.imtp.ilyichevsk.odessa.ua> (at Wed, 9 Jun 2004 14:25:39 +0300), Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> says:

> I observe that UDP sockets listening on ANY
> send response packets with ip addr derived from
> ip address of interface which is used to send 'em
> instead of using dst ip address of client's packet.

use IP_PKTINFO when responding the client.

--yoshfuji
