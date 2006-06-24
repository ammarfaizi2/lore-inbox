Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWFXMQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWFXMQH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 08:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWFXMQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 08:16:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28377 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964799AbWFXMQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 08:16:06 -0400
Subject: Re: PATCH: Change in-kernel afs client filesystem name to 'kafs'
From: Arjan van de Ven <arjan@infradead.org>
To: Troy Benjegerdes <hozer@hozed.org>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060624004154.GL5040@narn.hozed.org>
References: <20060624004154.GL5040@narn.hozed.org>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 14:16:00 +0200
Message-Id: <1151151360.3181.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-23 at 19:41 -0500, Troy Benjegerdes wrote:
> This patch changes the in-kernel AFS client filesystem name to 'kafs',
> as well as allowing the AFS cache manager port to be set as a module
> parameter. This is usefull for having a system boot with the root
> filesystem on afs with the kernel AFS client, while still having the
> option of loading the OpenAFS kernel module for use as a read-write
> filesystem later.

sounds weird... the filesystem it implements is afs.
your change also breaks userspace, since the fs type is a mount option
so your change is userspace visible and means people need to fix their
scripts...

maybe openafs should start using "openafs" as type; they're not in the
kernel so they aren't yet bound by the userspace ABI....


