Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263436AbTDXTSY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 15:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTDXTSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 15:18:24 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4740
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263436AbTDXTSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 15:18:23 -0400
Subject: Re: [PATCH 2.4] dmi_ident made public
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jean Delvare <khali@linux-fr.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Soos Peter <sp@osb.hu>
In-Reply-To: <20030424184759.5f7b3323.khali@linux-fr.org>
References: <20030424184759.5f7b3323.khali@linux-fr.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051209098.4005.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Apr 2003 19:31:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-04-24 at 17:47, Jean Delvare wrote:
> Hi everyone,
> 
> Here is a simple patch for the 2.4 kernel series that makes dmi_ident
> (as defined in arch/i386/kernel/dmi_scan.c) public.

The dmi scanner is __init, its gone after boot. The DMI tables on some
platforms may also have gone. What you actually want I suspect is a way
to register multiple DMI tables for boot time scanning to set further
flags in the dmi properties post scan.

Alan

