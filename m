Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTJCD3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 23:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbTJCD3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 23:29:21 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:13525 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263638AbTJCD3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 23:29:19 -0400
Message-ID: <3F7CED08.9080200@nortelnetworks.com>
Date: Thu, 02 Oct 2003 23:29:12 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au
Subject: compiling futex-2.2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried downloading and compiling the futex-2.2 package, and ran into 
some snags.

The linux/futex.h file uses a number of nonstandard data types but does 
not itself include any other headers.  IN addition, the "u32" data type 
  is problematic, since it is only defined in the kernel headers if 
__KERNEL__ is defined.  Perhaps it should be defined as "__u32"?

Also, there is a definition of sys_futex in the package headers that 
does not match the definition in the latest kernel headers.  Any plans 
to update the package?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

