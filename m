Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbTDGWYf (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263713AbTDGWYf (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:24:35 -0400
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:14269 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id S263711AbTDGWYd convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:24:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Richard J Moore <rasman@uk.ibm.com>
Organization: Linux Technoilogy Centre
Subject: Re: Debugging hard lockups (hardware?)
Date: Mon, 7 Apr 2003 23:24:32 +0000
User-Agent: KMail/1.4.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304072324.32050.rasman@uk.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 6 April 2003 8:31 pm, Dave Jones wrote:
> On Sun, Apr 06, 2003 at 07:34:09PM +0100, Alan Cox wrote:
>  > > 02:0a.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 01)
>  > > 02:0b.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 01)
>  >
>  > ...
>  > Your choice of components looks fine, its all stuff I trust, even if the
>  > ethernet card is not good for performance it ought to be fine in
>  > general. If it is a faulty part most likely its a one off fault.
>
> Note the IDE controller, and 2.5 bugzilla #123
> That controller has been nothing but trouble for me.
>
> 		Dave
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Do you know that your platform support a watchdog timer. Not every thing
 does, thought most do. It's probably worh verifying (cli; hlt;).
Is it possible you have experiennced a triple-fault? Most CPUs reset but some
have been known to freeze and require a manual reset. This can be verified
relatively easily (make int 8 descriptor NP then loop recursively - does the
system hang or reboot?).

--
Richard J Moore
IBM Linux Technology Centre


