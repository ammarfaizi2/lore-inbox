Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266853AbUG1JLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266853AbUG1JLo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 05:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266846AbUG1JJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 05:09:38 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:34058 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S266837AbUG1JIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 05:08:50 -0400
Date: Wed, 28 Jul 2004 11:09:50 +0200
From: DervishD <raul@pleyades.net>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: The dreadful CLOSE_WAIT
Message-ID: <20040728090950.GE32254@DervishD>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040727083947.GB31766@DervishD> <20040727160057.GE2334@holomorphy.com> <20040727171025.GA26146@DervishD> <20040727232724.GH2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040727232724.GH2334@holomorphy.com>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi William :)

 * William Lee Irwin III <wli@holomorphy.com> dixit:
> >> Probably best to implement timeouts by hand in your network daemon.
> >     Of course, this is a bug in the application, but anyway the
> > kernel (IMHO) shouldn't allow this.
> I suspect the sysctls controlling this, tcp_fin_timeout, tcp_max_orphans,
> etc., may be useful to you. Check Documentation/networking/ip-sysctl.txt

    tcp_fin_timeout is of no help here, since the server is not stuck
in FIN_WAIT2, and in addition to this, the connection is not closed,
that is exactly the problem. tcp_max_orphans refer to TCP connections
not attached to any user file handle, but a connection in state
CLOSE_WAIT is still attached to a file handle, to a valid one indeed.

    A grep in the kernel sources didn't give any useful guide about
which sysctl parameter will help :((

    Thanks anyway, William :) Maybe tcp_max_orphans can help, don't
know.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
