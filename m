Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136381AbREDNdj>; Fri, 4 May 2001 09:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136384AbREDNda>; Fri, 4 May 2001 09:33:30 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:51637 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S136381AbREDNdU>; Fri, 4 May 2001 09:33:20 -0400
From: Christoph Rohland <cr@sap.com>
To: Jacek Kopecky <jacek@idoox.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: tmpfs doesn't update free memory stats?
In-Reply-To: <Pine.LNX.4.33.0105041159301.31964-100000@bimbo.in.idoox.com>
Organisation: SAP LinuxLab
Date: 04 May 2001 15:13:09 +0200
In-Reply-To: <Pine.LNX.4.33.0105041159301.31964-100000@bimbo.in.idoox.com>
Message-ID: <m3g0eltfyy.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On Fri, 4 May 2001, Jacek Kopecky wrote:
>  I'm not in the list, please cc your replies to me.
>  After upgrading to 2.4.4 I started using tmpfs for /tmp and I
> noticed a strange behavior:
> 
>  dd if=/dev/zero of=blah bs=1024 count=102400
> 	# increased my used swap space by approx. 100MiB (correct)
>  rm blah
> 	# did not decrease it back
> 
>  Multiple retries showed what looked like a random behavior of
> the used swap stats. Is this a correct behavior? Should the swap
> stats be dismissed as 'unreliable'? I expected that when creating
> a 100MiB file in memory it should increase the swap (or memory)
> usage by cca 100MiB and that removing a file from tmpfs means
> freeing the memory.

It will be adjusted under memory pressure. At this time there is no
way to release swap cached pages without the potential of deadlocks.

This is not nice but the only short term solution and should not
affect anything besides stats.

Greetings
		Christoph


