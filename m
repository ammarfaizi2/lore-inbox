Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbTFPWMm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 18:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbTFPWMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 18:12:42 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:31926 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264434AbTFPWMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 18:12:41 -0400
Date: Mon, 16 Jun 2003 15:27:07 -0700
From: Andrew Morton <akpm@digeo.com>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, janiceg@us.ibm.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, stekloff@us.ibm.com, girouard@us.ibm.com,
       lkessler@us.ibm.com, kenistonj@us.ibm.com, jgarzik@pobox.com
Subject: Re: patch for common networking error messages
Message-Id: <20030616152707.58da808c.akpm@digeo.com>
In-Reply-To: <20030616.135124.71580008.davem@redhat.com>
References: <3EEE28DE.6040808@us.ibm.com>
	<20030616.133841.35533284.davem@redhat.com>
	<20030616205342.GH30400@wotan.suse.de>
	<20030616.135124.71580008.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jun 2003 22:26:34.0894 (UTC) FILETIME=[584032E0:01C33456]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
>
>    From: Andi Kleen <ak@suse.de>
>    Date: Mon, 16 Jun 2003 22:53:42 +0200
>    
>    Why? It will make supporting netconsole easier which has to be careful
>    to never recurse in the network driver.
> 
> printk can check this

Actually it already does, to cover the case where an interrupt handler calls
printk while process-context code is performing a printk.

The nested printk will squirt the message into the log buffer and the
"outer" code will display it.

