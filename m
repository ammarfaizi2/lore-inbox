Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266200AbSLPPey>; Mon, 16 Dec 2002 10:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266270AbSLPPey>; Mon, 16 Dec 2002 10:34:54 -0500
Received: from holomorphy.com ([66.224.33.161]:39859 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266200AbSLPPey>;
	Mon, 16 Dec 2002 10:34:54 -0500
Date: Mon, 16 Dec 2002 07:42:18 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "O. Sezer" <sezero@superonline.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rmap and nvidia?
Message-ID: <20021216154218.GA1922@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"O. Sezer" <sezero@superonline.com>, linux-kernel@vger.kernel.org
References: <20021216143446.KJIB19496.fep02@[212.252.122.46]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216143446.KJIB19496.fep02@[212.252.122.46]>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 04:25:11PM +0200, O. Sezer wrote:
> The 2.5 patches at http://www.minion.de/nvidia.html
> may give some clue. They use pte_offset_map , yes,
> but no corresponding pte_unmap ...

That will BUG() with highmem debugging on. Put the pte_unmap() in the
appropriate place.


Bill
