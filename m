Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267985AbUHFAeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267985AbUHFAeb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 20:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268028AbUHFAeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 20:34:31 -0400
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:44223 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S267985AbUHFAe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 20:34:27 -0400
Message-ID: <4112D32B.4060900@am.sony.com>
Date: Thu, 05 Aug 2004 17:39:07 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
CC: rth@twiddle.net
Subject: Is extern inline -> static inline OK?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pardon my ignorance...

Under what conditions is it NOT OK to convert "extern inline"
to "static inline"?

Linus once wrote:
>  - "static inline" means "we have to have this function, if you use it
>    but don't inline it, then make a static version of it in this
>    compilation unit"
> 
>  - "extern inline" means "I actually _have_ an extern for this function,
>    but if you want to inline it, here's the inline-version"
> 
> ... we should just convert
> all current users of "extern inline" to "static inline".

But Richard Henderson rejected (in 2002) the following patch (excerpt):

-#define __EXTERN_INLINE extern inline
+#define __EXTERN_INLINE static inline

presumably because the exact semantics of extern inline were
required.  I can only find __EXTERN_INLINE in the alpha
architecture.  Is the requirement to use 'extern' rather
than 'static' unique to alpha?

Thanks for any illumination on this.

=============================
Tim Bird
Architecture Group Co-Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
E-mail: tim.bird@am.sony.com
=============================
