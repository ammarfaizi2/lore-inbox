Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbTDVGqQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 02:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTDVGqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 02:46:16 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:36358 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S262953AbTDVGqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 02:46:15 -0400
Date: Tue, 22 Apr 2003 16:58:08 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: J Sloan <joe@tmsusa.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, <dlstevens@ibm.com>,
       <netdev@oss.sgi.com>
Subject: Re: 2.5.68 comments -  [udp broadcast reception broken]
In-Reply-To: <3EA382F1.205@tmsusa.com>
Message-ID: <Mutt.LNX.4.44.0304221649550.4809-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Apr 2003, J Sloan wrote:

> Looks good for the most part, but the rwhod
> problem is still with us. (The system is unable
> to receive udp broadcasts since early in the
> 2.5.67-bk release series)

This is being caused by the call to ip_mc_sf_allow() during packet
delivery, which is not needed for broadcasts.

(Broadcast & multicast packets share the same delivery path here).


- James
-- 
James Morris
<jmorris@intercode.com.au>


