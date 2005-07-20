Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVGTIqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVGTIqW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 04:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVGTIqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 04:46:21 -0400
Received: from ns.firmix.at ([62.141.48.66]:58270 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S261432AbVGTIqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 04:46:20 -0400
Subject: Re: [PATCH] v850: const-qualify first parameter of
	find_next_zero_bit
From: Bernd Petrovitsch <bernd@firmix.at>
To: Miles Bader <miles@gnu.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050720083830.5941F43F@mctpc71>
References: <20050720083830.5941F43F@mctpc71>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Wed, 20 Jul 2005 10:46:07 +0200
Message-Id: <1121849167.12525.12.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-20 at 17:38 +0900, Miles Bader wrote:
[...]
> @@ -157,7 +157,7 @@
>  #define find_first_zero_bit(addr, size) \
>    find_next_zero_bit ((addr), (size), 0)
>  
> -extern __inline__ int find_next_zero_bit (void *addr, int size, int offset)
> +extern __inline__ int find_next_zero_bit(const void *addr, int size, int offset)
>  {
>  	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);

Why not const-qualify *p and the cast also (avoiding warnings and
actually making the change complete)?

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

