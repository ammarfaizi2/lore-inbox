Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281116AbRLLRKy>; Wed, 12 Dec 2001 12:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281157AbRLLRKo>; Wed, 12 Dec 2001 12:10:44 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:54262 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S281116AbRLLRKj>; Wed, 12 Dec 2001 12:10:39 -0500
Date: Wed, 12 Dec 2001 09:14:12 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Near CPUs ...
Message-ID: <3126105393.1008148452@[10.10.1.2]>
In-Reply-To: <Pine.LNX.4.40.0112111806100.1500-100000@blue1.dev.mcafeelabs.com>
X-Mailer: Mulberry/2.0.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How to detect CPUs that are "near" ( on the same bus/mb ) on x86/ia64 hardware ?
> Is the MP configuration data structured in a way that makes you understand
> this mapping, ie :

IIRC, for HT, cpus with an APICid that only differ in the last bit are paired 
(ie (0,1), (2,3), (3,4) ....) 

For systems with clustered APIC ID, the cluster number is the top nibble of the 
logical APICid - CPUs with the same cluster number are in the same node.

For ia64, I'm not sure.

I suggest you look for Paul Dorwin's topology stuff - it's a more general mechanism
for describing this stuff - look back through the recent lse-tech archives.

Martin.

