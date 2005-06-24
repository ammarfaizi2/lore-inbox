Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263240AbVFXLRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263240AbVFXLRh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 07:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbVFXLPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 07:15:00 -0400
Received: from quechua.inka.de ([193.197.184.2]:55961 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S263270AbVFXLNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 07:13:42 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <42BBB47C.9010002@slaphack.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1Dlm7u-0002Un-00@calista.eckenfels.6bone.ka-ip.net>
Date: Fri, 24 Jun 2005 13:13:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <42BBB47C.9010002@slaphack.com> you wrote:
> How about a poor-man's isolation -- any process other than that
> responsible for the transaction sees a consistent state, never a
> transaction-in-progress.  I'm sure there's a name for that.

It is Isolation Level Serializeable. It is the less performant isolation
level and still can generate deadlocks if you have two process doing
transactions.

A more simpler solution would be that process without transactions never see
infligt tx and a second process simple returnes a retry error if touching a
locked ressource.

Bernd
