Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271232AbTGWTL1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 15:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271224AbTGWTAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 15:00:08 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:12028 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271223AbTGWS75
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:59:57 -0400
Subject: Re: kernel bug in socketpair()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Glenn Fowler <gsf@research.att.com>
Cc: davem@redhat.com, dgk@research.att.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
In-Reply-To: <200307231854.OAA90112@raptor.research.att.com>
References: <200307231428.KAA15254@raptor.research.att.com>
	 <20030723074615.25eea776.davem@redhat.com>
	 <200307231656.MAA69129@raptor.research.att.com>
	 <20030723100043.18d5b025.davem@redhat.com>
	 <200307231724.NAA90957@raptor.research.att.com>
	 <20030723103135.3eac4cd2.davem@redhat.com>
	 <200307231814.OAA74344@raptor.research.att.com>
	 <20030723112307.5b8ae55c.davem@redhat.com>
	 <200307231854.OAA90112@raptor.research.att.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058987301.5520.111.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2003 20:08:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-23 at 19:54, Glenn Fowler wrote:
> named unix sockets reside in the fs namespace, no?
> so they must be linked to a dir before use and unlinked after use
> the unlink after use would be particularly tricky for the parent process
> implementing
> 	cmd <(cmd ...) ...

Portable stuff yes, Linux also supports a pure socket namespace for them
when the path starts with a nul character

