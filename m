Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264423AbUADVkj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 16:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264467AbUADVki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 16:40:38 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:55763 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S264423AbUADVkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 16:40:36 -0500
To: erik@hensema.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0: something is leaking memory
References: <slrnbvgohn.1pb.erik@dexter.hensema.net>
	<Pine.LNX.4.58.0401041257290.2162@home.osdl.org>
	<slrnbvh1hd.jl6.erik@dexter.hensema.net>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 04 Jan 2004 13:39:22 -0800
In-Reply-To: <slrnbvh1hd.jl6.erik@dexter.hensema.net>
Message-ID: <52wu87wfzp.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Jan 2004 21:39:23.0384 (UTC) FILETIME=[37FB8F80:01C3D30B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yup, looks like IPv6 is leaking memory (since your netstat shows
nowhere near 19K sockets):

 > tcp6_sock          19729  19732   1024    4    1 : tunables   54   27    0 : slabdata   4933   4933      0

Now to figure out why...

 - R.
