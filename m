Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265053AbUIIOe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUIIOe3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 10:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbUIIOe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 10:34:29 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:48523
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S265106AbUIIOeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 10:34:10 -0400
Message-ID: <414069DF.9000804@bio.ifi.lmu.de>
Date: Thu, 09 Sep 2004 16:34:07 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix leak with bounced bio's
References: <20040909084204.GO1737@suse.de>
In-Reply-To: <20040909084204.GO1737@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Hi,
> 
> This might fix the last leak of memory reported with cd writing, the
> current highmem bounce code will leak n-1 pages for any n page bio where
> n > 1. CD writing typically uses 16 pages bios, so it is affected.


it fixes the leak for us that I described a while back
http://marc.theaimsgroup.com/?l=linux-kernel&m=109360958318479&w=2

Great :-))

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

