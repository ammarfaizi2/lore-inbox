Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292916AbSCDVii>; Mon, 4 Mar 2002 16:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292918AbSCDVia>; Mon, 4 Mar 2002 16:38:30 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:18948 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S292916AbSCDViO>; Mon, 4 Mar 2002 16:38:14 -0500
Date: Mon, 4 Mar 2002 18:37:52 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, <andrea@suse.de>,
        <phillips@bonn-fries.net>, <davidsen@tmr.com>, <mfedyk@matchmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <20020304191804.2e58761c.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.44L.0203041837150.1413-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002, Stephan von Krawczynski wrote:
> On Mon, 04 Mar 2002 08:59:10 -0800
> "Martin J. Bligh" <Martin.Bligh@us.ibm.com> wrote:
>
> > 2) We can do local per-node scanning - no need to bounce
> > information to and fro across the interconnect just to see what's
> > worth swapping out.
>
> Well, you can achieve this by "attaching" the nodes' local memory (zone)
> to its cpu and let the vm work preferably only on these attached zones
> (regarding the list scanning and the like). This way you have no
> interconnect traffic generated. But this is in no way related to rmap.

But it is.  Without -rmap you don't know which processes from
which nodes could have mapped memory on your node, so you end
up scanning the page tables of all processes on all nodes.

regards,

Rik
-- 
Will hack the VM for food.

http://www.surriel.com/		http://distro.conectiva.com/

