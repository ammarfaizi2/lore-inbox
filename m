Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286161AbSA2W7Y>; Tue, 29 Jan 2002 17:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285692AbSA2W7G>; Tue, 29 Jan 2002 17:59:06 -0500
Received: from holomorphy.com ([216.36.33.161]:29855 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S285516AbSA2W6t>;
	Tue, 29 Jan 2002 17:58:49 -0500
Date: Tue, 29 Jan 2002 15:00:37 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org,
        linux-mm@nl.linux.org, velco@fadata.bg
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020129150037.M899@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org,
	linux-mm@nl.linux.org, velco@fadata.bg
In-Reply-To: <20020129165444.A26626@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20020129165444.A26626@caldera.de>; from hch@caldera.de on Tue, Jan 29, 2002 at 04:54:44PM +0100
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 04:54:44PM +0100, Christoph Hellwig wrote:
> I've ported my hacked up version of Momchil Velikov's radix tree
> radix tree pagecache to 2.5.3-pre{5,6}.
> The changes over the 2.4.17 version are:
>   o use mempool to avoid OOM situation involving radix nodes.
>   o remove add_to_page_cache_locked, it was unused in the 2.4.17 patch.
>   o unify add_to_page and add_to_page_unique
> It gives nice scalability improvements on big machines and drops the
> memory usage on small ones (if you consider my 64MB Athlon small :)).

I love this patch. My only concern is about worst-case space consumption,
but it is beautiful regardless, and space consumption can be addressed
later if it is a problem in practice. The average case space consumption,
as you have noted, is quite good already, and it seems difficult to
trigger the worst case (I have tested it myself).


Cheers,
Bill
