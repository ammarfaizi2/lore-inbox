Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262841AbVBDAkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbVBDAkm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 19:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVBDAkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 19:40:41 -0500
Received: from hera.kernel.org ([209.128.68.125]:17368 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S263319AbVBDAhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 19:37:47 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [patch 1/1] fix syscallN() macro errno value checking for i386
Date: Fri, 4 Feb 2005 00:36:43 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <ctug2r$rjc$1@terminus.zytor.com>
References: <20050129010145.1C42F8C9E4@zion> <200501301800.22706.arnd@arndb.de> <5a2cf1f605013010305f8270de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1107477403 28269 127.0.0.1 (4 Feb 2005 00:36:43 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 4 Feb 2005 00:36:43 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <5a2cf1f605013010305f8270de@mail.gmail.com>
By author:    jerome lacoste <jerome.lacoste@gmail.com>
In newsgroup: linux.dev.kernel
> 
> what about something along?
> 
> #define EKEYNEXT    130     /* key counter */
> 
> and 
> 
>  if ((unsigned long)(res) >= (unsigned long)(-EKEYNEXT)) {
> 

What you really need is EMAX.

	-hpa
