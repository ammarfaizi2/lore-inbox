Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTE2JtK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 05:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbTE2JtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 05:49:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54436 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262066AbTE2JtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 05:49:08 -0400
Date: Thu, 29 May 2003 03:01:16 -0700 (PDT)
Message-Id: <20030529.030116.115912655.davem@redhat.com>
To: ak@suse.de
Cc: pavel@suse.cz, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: must-fix list, v5
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030529094648.GB15333@wotan.suse.de>
References: <p73wuga6rin.fsf@oldwotan.suse.de>
	<20030529.023203.41634240.davem@redhat.com>
	<20030529094648.GB15333@wotan.suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Thu, 29 May 2003 11:46:48 +0200

   I believe the remaining limits are harmless, but of course it's cleaner
   to not have them.
   
The ethtool one was the worst.  It's why I didn't copy your code :-)

   If you use the function that extensively it would be better to allow
   it to nest (e.g. add a field for the current offset in  task struct). 
   Otherwise someone will get it wrong sooner or later.
   (like the sock/tw_bucket ;) 
   
This is why I kept it private to the compat layer, I see no reason
to let it slip into other code at all.

   Ok thanks. I will port it to my 2.4 code.
   
   Did you test them all?

I tested most of them, but very lightly.  I didn't test the
SG_IO stuff but that barely worked even beforehand :-)
