Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbUC2WIe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 17:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUC2WIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 17:08:34 -0500
Received: from fmr06.intel.com ([134.134.136.7]:12260 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263150AbUC2WIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 17:08:32 -0500
Subject: Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
From: Len Brown <len.brown@intel.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20040329052238.GD1276@alpha.home.local>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com>
	 <1080535754.16221.188.camel@dhcppc4>
	 <20040329052238.GD1276@alpha.home.local>
Content-Type: text/plain
Organization: 
Message-Id: <1080598062.983.3.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 29 Mar 2004 17:07:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-29 at 00:22, Willy Tarreau wrote:

> > 4. re-implement locks for the 80386 case.
> 
> I like this one, but a simpler way : don't support SMP in this case, so that
> we won't have to play with locks. This would lead to something like this :

Linux uses this locking mechanism to coordinate shared access
to hardware registers with embedded controllers,
which is true also on uniprocessors too.

thanks,
-Len


