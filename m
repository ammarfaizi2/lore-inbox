Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271698AbRHQRHZ>; Fri, 17 Aug 2001 13:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271697AbRHQRHP>; Fri, 17 Aug 2001 13:07:15 -0400
Received: from cmailg5.svr.pol.co.uk ([195.92.195.175]:24916 "EHLO
	cmailg5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S271695AbRHQRHC>; Fri, 17 Aug 2001 13:07:02 -0400
Message-ID: <3B7D4F30.5090302@humboldt.co.uk>
Date: Fri, 17 Aug 2001 18:06:56 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Holger Lubitz <h.lubitz@internet-factory.de>, linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <Pine.LNX.3.95.1010817111201.863A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> Errrm no. All BIOS that anybody would use write all memory found when
> initializing the SDRAM controller. They need to because nothing,
> refresh, precharge, (or if you've got it, parity/crc) will work
> until every cell is exercised. A "warm-boot" is different. However,
> if you hit the reset or the power switch, nothing in RAM survives.

This does not match my experience building SDRAM based embedded systems. 
Initialising SDRAM simply tells the chips what CAS latency to use, and 
does not erase the contents. SDRAM is fully functional before you have 
written to every cell.

It's possible that JEDEC standards recommend that boot firmware should 
erase the contents, and it is certainly necessary to erase before 
enabling ECC or parity error detection.

-- 
Adrian Cox   http://www.humboldt.co.uk/

