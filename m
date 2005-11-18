Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030592AbVKRJem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030592AbVKRJem (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 04:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030597AbVKRJem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 04:34:42 -0500
Received: from silver.veritas.com ([143.127.12.111]:26782 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1030592AbVKRJel
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 04:34:41 -0500
Date: Fri, 18 Nov 2005 09:33:20 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "David S. Miller" <davem@davemloft.net>
cc: nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] unpaged: COW on VM_UNPAGED
In-Reply-To: <20051118.003606.59385217.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0511180920110.6333@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511180730530.5435@goblin.wat.veritas.com>
 <20051118.000802.81426185.davem@davemloft.net>
 <Pine.LNX.4.61.0511180813110.5788@goblin.wat.veritas.com>
 <20051118.003606.59385217.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 18 Nov 2005 09:34:41.0244 (UTC) FILETIME=[4D2889C0:01C5EC23]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2005, David S. Miller wrote:
> 
> If we use MAP_SHARED and let vbetool modify the real BIOS data
> area, resume fails.  That's convincing enough for me :)

Yes, I agree with your analysis: I was expecting Dominik's resume
failure to have a more conventional cause, but yes, it's from that
new vbetool actually corrupting the memory instead of using it as
a template.

Right, no warning message then.  (Some other time we might want to
withdraw the feature - as you said, they could just read /dev/mem -
and put in a research warning in preparation; but right now I've
had enough of such noise.)

Dominik's Bad page states I'll be thinking about later in the day.

Hugh
