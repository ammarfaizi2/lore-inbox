Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUANSVf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 13:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbUANSVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 13:21:34 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:24219 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262794AbUANSVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 13:21:33 -0500
Date: Wed, 14 Jan 2004 10:20:52 -0800
To: Jes Sorensen <jes@trained-monkey.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.1-mm3 quiet down SMP boot messages
Message-ID: <20040114182052.GA8574@sgi.com>
Mail-Followup-To: Jes Sorensen <jes@trained-monkey.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <16389.21138.564775.207535@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16389.21138.564775.207535@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 09:30:42AM -0500, Jes Sorensen wrote:
> @@ -1118,6 +1117,7 @@
>  
>  	for(i = 0 ; i < numnodes ; i++)
>  		build_zonelists(NODE_DATA(i));
> +	printk("Built %i zonelists\n", numnodes);
>  }

How many of these for (i = 0; i < numnodes; i++) loops do we have?
Should we have a for_each_node() function like we do for CPUs?  Isn't
there a node_online() thing that many loops are missing?

Thanks,
Jesse
