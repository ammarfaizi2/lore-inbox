Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTEEXbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 19:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTEEXbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 19:31:35 -0400
Received: from [80.111.51.24] ([80.111.51.24]:4480 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261651AbTEEXbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 19:31:33 -0400
Subject: Re: The disappearing sys_call_table export.
From: Terje Eggestad <terje.eggestad@scali.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200305051730_MC3-1-3780-86E0@compuserve.com>
References: <200305051730_MC3-1-3780-86E0@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 May 2003 00:49:34 +0200
Message-Id: <1052174975.1000.5.camel@eggis1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good point, it should actually be very simple.
from /proc/ksyms we've got teh adresses of the sys_*, then from
asm/unistd.h we got the order.
Then search thru /dev/kmem until you find the right string og addresses,
and you got sys_call_table. 

Dirty but it should be portable. 
 

On Mon, 2003-05-05 at 23:29, Chuck Ebbert wrote:
    > Lets deal, I'll GPL the trace module if you get me a 
    > EXPORT_SYMBOL_GPL(sys_call_table);
    
     You could always use the rootkit techniques from Phrack 58 to find
    the table... seems kind of silly to do that in kernel mode, but it
    should work.
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

