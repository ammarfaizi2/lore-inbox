Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267511AbSLLUdc>; Thu, 12 Dec 2002 15:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267512AbSLLUdc>; Thu, 12 Dec 2002 15:33:32 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:12731 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267511AbSLLUdb>; Thu, 12 Dec 2002 15:33:31 -0500
Message-ID: <3DF8F38D.E2A47634@us.ibm.com>
Date: Thu, 12 Dec 2002 12:37:33 -0800
From: Nivedita Singhvi <niv@us.ibm.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: stefano.andreani.ap@h3g.it, linux-kernel@vger.kernel.org
Subject: Re: R: Kernel bug handling TCP_RTO_MAX?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Never say never ;-) 
> I need to change it now as a temporary workaround for a problem in the UMTS core \
> network of my company. But I think there could be thousands of situations where a \
> fine tuning of this TCP parameter could be useful.
> 
> Any contributes on the problem?


If what you are trying to do is terminate the connection earlier,
than reduce the tcp sysctl variable tcp_retries2. This should be the
maximum number of retransmits TCP will make in established state.

The TCP_RTO_MAX parameter is simply an *upper bound* on the 
value of the retransmission timeout, which increases exponentially
from the original timeout value. 

thanks,
Nivedita
