Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWGKICy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWGKICy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 04:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWGKICy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 04:02:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26838 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750722AbWGKICx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 04:02:53 -0400
Subject: Re: [PATCH -mm 0/7] execns syscall and user namespace
From: Arjan van de Ven <arjan@infradead.org>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20060711075051.382004000@localhost.localdomain>
References: <20060711075051.382004000@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 10:02:50 +0200
Message-Id: <1152604970.3128.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 09:50 +0200, Cedric Le Goater wrote:
> Hello !
> 
> The following patchset adds the user namespace and a new syscall execns.
> 
> The user namespace will allow a process to unshare its user_struct table,
> resetting at the same time its own user_struct and all the associated
> accounting.
> 
> The purpose of execns is to make sure that a process unsharing a namespace
> is free from any reference in the previous namespace. the execve() semantic
> seems to be the best candidate as it already flushes the previous process
> context.
> 
> Thanks for reviewing, sharing, flaming !

how does this interact with the unshare() syscall ?
can the unshare syscall be rigged up such that you have the same effect?


