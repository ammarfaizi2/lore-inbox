Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbVKVLQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbVKVLQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 06:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVKVLQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 06:16:28 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:41119 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S964913AbVKVLQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 06:16:27 -0500
Date: Tue, 22 Nov 2005 12:16:25 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.14] bug in inet_connection_sock.c -> lowest port always
	skipped
Message-ID: <20051122111625.GD32512@vanheusden.com>
References: <20051121180224.GY32512@vanheusden.com>
	<43820E23.2060303@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43820E23.2060303@trash.net>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Tue Nov 22 11:39:23 CET 2005
X-Message-Flag: www.unixexpert.nl
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >There seems to be a small bug in inet_connection_sock.c: the lowest port
> >set using sysctl (taken from 'sysctl_local_port_range') is always
> >skipped in the first iteration.
> >In inet_csk_get_port one can find this:
> >                if (hashinfo->port_rover < low)
> >                        rover = low;
> >                else
> >                        rover = hashinfo->port_rover;
> >                do {
> >                        rover++;
> >As you can see the first statement is a ++ causing the first port to
> >always be skipped.
> This has already been fixed three weeks ago by Stephen Hemminger's port
> randomization patch.

Great!


Folkert van Heusden

-- 
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
