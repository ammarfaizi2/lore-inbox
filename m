Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264663AbTFENEL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 09:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264664AbTFENEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 09:04:11 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:7108 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S264663AbTFENEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 09:04:10 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Re: select for UNIX sockets?
References: <m3llwkauq5.fsf@defiant.pm.waw.pl>
	<1054651886.9233.35.camel@dhcp22.swansea.linux.org.uk>
	<m3n0gxfmp3.fsf@defiant.pm.waw.pl>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 05 Jun 2003 15:17:46 +0200
In-Reply-To: <m3n0gxfmp3.fsf@defiant.pm.waw.pl>
Message-ID: <m3he74d5ol.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa <khc@pm.waw.pl> writes:

> but unix_peer_get(sk) returns NULL.

Well... I missed the fact that this program uses "unconnected" UNIX UDP.
Still, it shouldn't block on sendmsg after a successful select(), maybe
dropping the packet should be better?. It's not that simple.

Thanks for all replies, investigating this issue further.
-- 
Krzysztof Halasa
Network Administrator
