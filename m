Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264591AbSIVWrj>; Sun, 22 Sep 2002 18:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264593AbSIVWrj>; Sun, 22 Sep 2002 18:47:39 -0400
Received: from franka.aracnet.com ([216.99.193.44]:733 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264591AbSIVWrg>; Sun, 22 Sep 2002 18:47:36 -0400
Date: Sun, 22 Sep 2002 15:51:00 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Erich Focht <efocht@ess.nec.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
Message-ID: <98549676.1032709859@[10.10.2.3]>
In-Reply-To: <20020922223630.GG25605@holomorphy.com>
References: <20020922223630.GG25605@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Sep 22, 2002 at 11:59:16PM +0200, Erich Focht wrote:
>> A bit more difficult is tuning the scheduler parameters which can
>> be done pretty simply by changing the __node_distance matrix. A first
>> attempt could be: 10 on the diagonal, 100 off-diagonal. This leads to
>> larger delays when stealing from a remote node.
> 
> This is not entirely reflective of our architecture. Node-to-node
> latencies vary as well. Some notion of whether communication must cross
> a lash at the very least should be present.

Ummm ... I think it's just flat on or off node, presumably Erich
has "on the diagonal" meaning they're on the same node, and 
"off-diagonal" meaning they're not. In which case, what he suggested
seems fine ... it's really about 20:1 ratio so I might use 10
and 200, but other than that, it seems correct to me.

M.

