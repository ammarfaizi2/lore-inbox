Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWC1J2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWC1J2t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 04:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWC1J2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 04:28:48 -0500
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:1000 "HELO
	briare1.heliogroup.fr") by vger.kernel.org with SMTP
	id S1751249AbWC1J2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 04:28:48 -0500
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: Harald Welte <laforge@netfilter.org>
Cc: linux-kernel@vger.kernel.org, netfilter@lists.netfilter.org
Subject: Re: failed to configure iptables with 2.6.16 kernel
Date: Tue, 28 Mar 2006 13:10:54 GMT
Message-ID: <064G9Y712@briare1.heliogroup.fr>
X-Mailer: Pliant 96
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte wrote:
>
> this sounds like you're missing support for the tcp/udp match.
> This functionality is implemented in xt_tcpudp.{c,ko}, which is compiled
> as soon as x_tables is compiled.

Loading 'xt_tcpudp' module solves the problem. Thanks for the answer.

So, the problem was just that the new 'x_tables' module is loaded automatically
according to modules dependencies, but 'xt_tcpudp' is not.
As a result, an upgrade of the FullPliant user land tools is required in order
to force the 'xt_tcpudp' module to load before calling 'iptables' with
'--destination-port' option.
