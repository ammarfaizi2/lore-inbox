Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTIZKbB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 06:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbTIZKbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 06:31:01 -0400
Received: from TK212017100193.teleweb.at ([212.17.100.193]:55212 "EHLO
	mail.tscheinig.com") by vger.kernel.org with ESMTP id S262052AbTIZKa5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 06:30:57 -0400
Message-ID: <3F74155A.3050207@tscheinig.com>
Date: Fri, 26 Sep 2003 12:30:50 +0200
From: Helmut Djurkin <djh@tscheinig.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en, de-at, de, en-us
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: vmware in Linux 2.6
References: <yw1xwubvq3vq.fsf@users.sourceforge.net>
In-Reply-To: <yw1xwubvq3vq.fsf@users.sourceforge.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Logged: Logged by mail.tscheinig.com as h8Q9vqF7015103 at Fri Sep 26 11:57:52 2003
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


from:
http://www.fearthecow.net/index.pl?section=guest&page=kernel

<snip>
VMWare:

You'll need to edit /usr/bin/vmware-config.pl

    1. Replace all occurances of /proc/ksyms with /proc/kallsyms
    2. Untar vmnet.tar in /usr/lib/vmware/modules/source
           * Edit bridge.c
           * On line 368, change: atomic_add(skb->truesize, 
&sk->wmem_alloc); into atomic_add(skb->truesize, &sk->sk_wmem_alloc);<
           * On line 618, change protinfo into sk_protinfo
           * Likewise, on line 817, change protinfo into sk_protinfo
    3. Tar the vmnet directory, and replace vmnet.tar
    4. Run /usr/bin/vmware-config.pl - it should run without a problem.
<snip>


Måns Rullgård wrote:
> Is it possible to use vmware with Linux 2.6?  The kernel modules
> (obviously) fail to compile.
> 



