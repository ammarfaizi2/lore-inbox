Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271400AbTHHPKe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 11:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271401AbTHHPKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 11:10:34 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:44175 "HELO
	develer.com") by vger.kernel.org with SMTP id S271400AbTHHPK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 11:10:27 -0400
Message-ID: <3F33BD57.8090904@develer.com>
Date: Fri, 08 Aug 2003 17:10:15 +0200
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Ville Herva <vherva@niksula.hut.fi>
CC: Aaron Lehmann <aaronl@vitelus.com>, gcc@gcc.gnu.org,
       linux-kernel@vger.kernel.org
Subject: Re: Big kernel size increase with gcc 3.4
References: <3F330D46.8020508@develer.com> <20030808024909.GT2712@vitelus.com> <20030808053327.GZ150921@niksula.cs.hut.fi>
In-Reply-To: <20030808053327.GZ150921@niksula.cs.hut.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva wrote:

>>You should try -Os if you want to optimize for size.
> 
> I was about to suggest that, too.
> 
> It could be that while optimizing for speed, gcc 3.4 simply inlines way more
> by default (whether or not that actually makes the code faster is a
> different question). I think -Os could be a better comparison.

You were both right. With -Os, GCC 3.3.1 and 3.4 perform
similarly, with a slight advantage for 3.4 :-)

   text    data     bss     dec     hex filename
 833352   47200   78884  959436   ea3cc vmlinux_gcc331
 807140   48036   78884  934060   e40ac vmlinux_gcc331_Os
 796264   50560   78884  925708   e200c vmlinux_gcc34_Os

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html



