Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129064AbQKBSKa>; Thu, 2 Nov 2000 13:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129069AbQKBSKU>; Thu, 2 Nov 2000 13:10:20 -0500
Received: from runyon.cygnus.com ([205.180.230.5]:169 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S129064AbQKBSKB>;
	Thu, 2 Nov 2000 13:10:01 -0500
To: root@chaos.analogic.com
Cc: kernel@kvack.org, "Dr. David Gilbert" <dg@px.uk.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Dual XEON - >>SLOW<< on SMP
In-Reply-To: <Pine.LNX.3.95.1001102090044.8621A-100000@chaos.analogic.com>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
From: Ulrich Drepper <drepper@redhat.com>
Date: 02 Nov 2000 10:09:36 -0800
In-Reply-To: "Richard B. Johnson"'s message of "Thu, 2 Nov 2000 09:02:38 -0500 (EST)"
Message-ID: <m3bsvy2qlb.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> Yes. Look at the NMI count. Looks like every access produces a
> NMI.

I'm seeing this as well, but only with PIII Xeon systems, not PII
Xeon.  Every single timer interrupt on any CPU is accompanied by a NMI
and LOC increment on every CPU.

           CPU0       CPU1       
  0:     146727     153389    IO-APIC-edge  timer
[...]
NMI:     300035     300035 
LOC:     300028     300028 


-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
