Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136868AbREJSJJ>; Thu, 10 May 2001 14:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136877AbREJSI7>; Thu, 10 May 2001 14:08:59 -0400
Received: from t2.redhat.com ([199.183.24.243]:6396 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S136869AbREJSIr>; Thu, 10 May 2001 14:08:47 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.21.0105101826290.11103-100000@mrbusy.compsoc.man.ac.uk> 
In-Reply-To: <Pine.LNX.4.21.0105101826290.11103-100000@mrbusy.compsoc.man.ac.uk> 
To: John Levon <moz@compsoc.man.ac.uk>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: [PATCH] Small kernel-api addition 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 10 May 2001 19:05:05 +0100
Message-ID: <18661.989517905@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


moz@compsoc.man.ac.uk said:
+ * This macro should be used for accessing values larger in size than single
+ * bytes at locations that may be improperly aligned, e.g. retrieving a u16 
+ * value from a location not u16-aligned. 

I'd suggest s/that may be/that are expected to be/

If it's _expected_, then by all means use {get,put}_unaligned(). If it's 
normally going to be aligned, and it _may_ occasionally be otherwise, let 
the common case go fast, and let the fixup handle it otherwise.


--
dwmw2


