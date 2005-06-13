Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVFMM0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVFMM0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 08:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVFMM0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 08:26:24 -0400
Received: from main.gmane.org ([80.91.229.2]:40623 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261538AbVFMM0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 08:26:18 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: udp.c
Date: Mon, 13 Jun 2005 14:24:55 +0200
Message-ID: <yw1xy89ebg14.fsf@ford.inprovide.com>
References: <42AD74A3.1050006@active.by> <1118664180.898.13.camel@tara.firmix.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:CWf0PMBCbGzRwOxt9xZb4sm6tVM=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch <bernd@firmix.at> writes:

> On Mon, 2005-06-13 at 14:57 +0300, Rommer wrote:
>> Where used strange function udp_v4_hash?
>> linux-2.6.11.11, net/ipv4/udp.c:204
>> 
>> static void udp_v4_hash(struct sock *sk)
>
> Since it is "static" the user must be in the same source file (or -
> theoretically - any included header).

It's not that simple.  It is assigned to the 'hash' field of a struct
proto, which is exported.  It could be used from anywhere, but
hopefully isn't.  Something else is supposed to ensure that it is
never called when using the UDP protocol.

-- 
Måns Rullgård
mru@inprovide.com

